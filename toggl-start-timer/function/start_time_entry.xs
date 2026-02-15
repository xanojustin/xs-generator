function "start_time_entry" {
  description = "Start a new time entry in Toggl Track"
  input {
    text workspace_id filters=trim { description = "Toggl workspace ID" }
    text description filters=trim { description = "Description of the time entry" }
    text billable?="false" filters=trim { description = "Whether the entry is billable (true/false, default: false)" }
    text project_id? filters=trim { description = "Optional project ID to associate with the time entry" }
    text tags? filters=trim { description = "Optional comma-separated list of tags" }
  }

  stack {
    // Get credentials from environment
    var $api_token { value = $env.TOGGL_API_TOKEN }
    var $email { value = $env.TOGGL_EMAIL }

    // Validate API token is configured
    precondition ($api_token != null && $api_token != "") {
      error_type = "standard"
      error = "TOGGL_API_TOKEN environment variable not configured"
    }

    // Validate workspace ID is provided
    precondition ($input.workspace_id != null && $input.workspace_id != "") {
      error_type = "inputerror"
      error = "Workspace ID is required"
    }

    // Validate description is provided
    precondition ($input.description != null && $input.description != "") {
      error_type = "inputerror"
      error = "Description is required"
    }

    // Parse billable boolean
    var $is_billable { 
      value = ($input.billable|lower == "true") 
    }

    // Get current UTC timestamp for start time
    var $start_time { value = util.timestamp|to_text|date:"Y-m-d\TH:i:s.v\Z" }

    // Build base payload
    var $payload {
      value = {
        created_with: "XanoScript Run Job",
        description: $input.description,
        billable: $is_billable,
        workspace_id: $input.workspace_id|to_number,
        duration: -1,
        start: $start_time,
        stop: null,
        tags: []
      }
    }

    // Add project ID if provided
    conditional {
      if ($input.project_id != null && $input.project_id != "") {
        var.update $payload {
          value = $payload|set:"project_id":($input.project_id|to_number)
        }
      }
    }

    // Parse and add tags if provided
    conditional {
      if ($input.tags != null && $input.tags != "") {
        var $tag_list { 
          value = $input.tags|split:","
        }
        // Trim each tag
        var $cleaned_tags {
          value = $tag_list|map:($this|trim)
        }
        var.update $payload {
          value = $payload|set:"tags":$cleaned_tags
        }
      }
    }

    // Build authentication header (Basic auth with email:api_token)
    var $auth_string { 
      value = $email ~ ":" ~ $api_token 
    }
    var $auth_encoded {
      value = $auth_string|base64_encode
    }

    // Send the request to Toggl
    api.request {
      url = "https://api.track.toggl.com/api/v9/workspaces/" ~ $input.workspace_id ~ "/time_entries"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ $auth_encoded
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $time_entry_id { value = null }
    var $error_message { value = null }
    var $duration { value = null }
    var $entry_start { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $time_entry_id { value = $response_body|get:"id" }
        var $duration { value = $response_body|get:"duration" }
        var $entry_start { value = $response_body|get:"start" }
      }
      elseif ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $time_entry_id { value = $response_body|get:"id" }
        var $duration { value = $response_body|get:"duration" }
        var $entry_start { value = $response_body|get:"start" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Toggl API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_detail { value = $api_result.response.result|get:"message" }
            conditional {
              if ($error_detail != null) {
                var $error_message {
                  value = $error_detail
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    time_entry_id: $time_entry_id,
    description: $input.description,
    workspace_id: $input.workspace_id,
    start_time: $entry_start,
    duration: $duration,
    running: true,
    error: $error_message
  }
}
