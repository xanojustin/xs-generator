function "create_issue" {
  description = "Create a new issue in a GitLab project"
  input {
    text project_id filters=trim { description = "GitLab project ID or URL-encoded path (e.g., '12345678' or 'group%2Fproject')" }
    text title filters=trim { description = "Title of the issue" }
    text description? filters=trim { description = "Description of the issue (supports Markdown)" }
    text labels? filters=trim { description = "Comma-separated label names (e.g., 'bug,critical')" }
    text assignee_id? filters=trim { description = "User ID to assign the issue to (optional)" }
    text milestone_id? filters=trim { description = "Milestone ID to assign the issue to (optional)" }
  }

  stack {
    // Get configuration from environment
    var $gitlab_token { value = $env.GITLAB_TOKEN }
    var $gitlab_base_url { value = $env.GITLAB_BASE_URL }

    // Validate GitLab token is configured
    precondition ($gitlab_token != null && $gitlab_token != "") {
      error_type = "standard"
      error = "GITLAB_TOKEN environment variable not configured"
    }

    // Set default base URL if not provided
    conditional {
      if ($gitlab_base_url == null || $gitlab_base_url == "") {
        var $gitlab_base_url { value = "https://gitlab.com" }
      }
    }

    // Validate required inputs
    precondition ($input.project_id != null && $input.project_id != "") {
      error_type = "inputerror"
      error = "Project ID is required"
    }

    precondition ($input.title != null && $input.title != "") {
      error_type = "inputerror"
      error = "Issue title is required"
    }

    // Build the request payload
    var $payload {
      value = {
        title: $input.title
      }
    }

    // Add description if provided
    conditional {
      if ($input.description != null && $input.description != "") {
        var.update $payload {
          value = $payload|set:"description":$input.description
        }
      }
    }

    // Add labels if provided
    conditional {
      if ($input.labels != null && $input.labels != "") {
        var.update $payload {
          value = $payload|set:"labels":$input.labels
        }
      }
    }

    // Add assignee if provided
    conditional {
      if ($input.assignee_id != null && $input.assignee_id != "") {
        var.update $payload {
          value = $payload|set:"assignee_ids":[$input.assignee_id|to_int]
        }
      }
    }

    // Add milestone if provided
    conditional {
      if ($input.milestone_id != null && $input.milestone_id != "") {
        var.update $payload {
          value = $payload|set:"milestone_id":$input.milestone_id|to_int
        }
      }
    }

    // Construct the API URL
    var $api_url {
      value = $gitlab_base_url ~ "/api/v4/projects/" ~ $input.project_id ~ "/issues"
    }

    // Send the request to GitLab
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $gitlab_token
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $issue_id { value = null }
    var $issue_iid { value = null }
    var $issue_url { value = null }
    var $issue_state { value = null }
    var $created_at { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $issue_id { value = $response_body|get:"id" }
        var $issue_iid { value = $response_body|get:"iid" }
        var $issue_url { value = $response_body|get:"web_url" }
        var $issue_state { value = $response_body|get:"state" }
        var $created_at { value = $response_body|get:"created_at" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "GitLab API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $response_body|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj|to_text
                }
              }
            }
            // Try to get message field if error object doesn't exist
            conditional {
              if ($error_obj == null) {
                var $message { value = $api_result.response.result|get:"message" }
                conditional {
                  if ($message != null) {
                    var $error_message {
                      value = $message|to_text
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
    issue_id: $issue_id,
    issue_iid: $issue_iid,
    issue_url: $issue_url,
    state: $issue_state,
    created_at: $created_at,
    error: $error_message
  }
}
