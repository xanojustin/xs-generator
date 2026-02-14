function "create_asana_task" {
  description = "Create a new task in Asana"
  input {
    text name filters=trim { description = "Name/title of the task (required)" }
    text project_id filters=trim { description = "Asana project ID where the task should be created (required)" }
    text workspace_id? filters=trim { description = "Asana workspace ID (optional if project_id is provided)" }
    text notes? filters=trim { description = "Task description/notes (optional)" }
    text assignee? filters=trim { description = "Assignee email or user ID (optional)" }
    text due_on? filters=trim { description = "Due date in YYYY-MM-DD format (optional)" }
    text[] tags? { description = "Array of tag names to apply (optional)" }
    bool completed?=false { description = "Whether the task is completed (default: false)" }
  }

  stack {
    // Get access token from environment
    var $access_token { value = $env.ASANA_ACCESS_TOKEN }

    // Validate access token is configured
    precondition ($access_token != null && $access_token != "") {
      error_type = "standard"
      error = "ASANA_ACCESS_TOKEN environment variable not configured"
    }

    // Validate name is provided
    precondition ($input.name != null && $input.name != "") {
      error_type = "inputerror"
      error = "Task name is required"
    }

    // Validate project_id is provided
    precondition ($input.project_id != null && $input.project_id != "") {
      error_type = "inputerror"
      error = "Project ID is required"
    }

    // Build the task data object
    var $task_data {
      value = {
        name: $input.name,
        projects: [$input.project_id]
      }
    }

    // Add notes if provided
    conditional {
      if ($input.notes != null && $input.notes != "") {
        var.update $task_data {
          value = $task_data|set:"notes":$input.notes
        }
      }
    }

    // Add assignee if provided
    conditional {
      if ($input.assignee != null && $input.assignee != "") {
        var.update $task_data {
          value = $task_data|set:"assignee":$input.assignee
        }
      }
    }

    // Add due date if provided
    conditional {
      if ($input.due_on != null && $input.due_on != "") {
        var.update $task_data {
          value = $task_data|set:"due_on":$input.due_on
        }
      }
    }

    // Add tags if provided
    conditional {
      if ($input.tags != null && ($input.tags|count) > 0) {
        var.update $task_data {
          value = $task_data|set:"tags":$input.tags
        }
      }
    }

    // Add completed status
    conditional {
      if ($input.completed == true) {
        var.update $task_data {
          value = $task_data|set:"completed":true
        }
      }
    }

    // Build the request payload with 'data' wrapper
    var $payload {
      value = {
        data: $task_data
      }
    }

    // Send the request to Asana
    api.request {
      url = "https://app.asana.com/api/1.0/tasks"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $task_id { value = null }
    var $task_name { value = null }
    var $task_url { value = null }
    var $created_at { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $task { value = $response_body|get:"data" }
        var $success { value = true }
        var $task_id { value = $task|get:"gid" }
        var $task_name { value = $task|get:"name" }
        var $created_at { value = $task|get:"created_at" }
        // Build task URL from task ID
        conditional {
          if ($task_id != null) {
            var $task_url {
              value = "https://app.asana.com/0/" ~ $input.project_id ~ "/" ~ $task_id
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Asana API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_body { value = $api_result.response.result|get:"errors" }
            conditional {
              if ($error_body != null) {
                var $first_error { value = $error_body|first }
                conditional {
                  if ($first_error != null) {
                    var $error_message {
                      value = $first_error|get:"message"
                    }
                  }
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
    task_id: $task_id,
    task_name: $task_name,
    task_url: $task_url,
    created_at: $created_at,
    error: $error_message
  }
}
