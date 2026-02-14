function "create_github_issue" {
  description = "Create an issue in a GitHub repository"
  input {
    text owner filters=trim { description = "Repository owner (username or organization)" }
    text repo filters=trim { description = "Repository name" }
    text title filters=trim { description = "Issue title" }
    text body? filters=trim { description = "Issue body/description (optional, supports Markdown)" }
    text labels? filters=trim { description = "Comma-separated list of label names (optional)" }
    text assignees? filters=trim { description = "Comma-separated list of GitHub usernames to assign (optional)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.GITHUB_TOKEN }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "GITHUB_TOKEN environment variable not configured"
    }

    // Validate owner is provided
    precondition ($input.owner != null && $input.owner != "") {
      error_type = "inputerror"
      error = "Repository owner is required"
    }

    // Validate repo is provided
    precondition ($input.repo != null && $input.repo != "") {
      error_type = "inputerror"
      error = "Repository name is required"
    }

    // Validate title is provided
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

    // Add body if provided
    conditional {
      if ($input.body != null && $input.body != "") {
        var.update $payload {
          value = $payload|set:"body":$input.body
        }
      }
    }

    // Add labels if provided
    conditional {
      if ($input.labels != null && $input.labels != "") {
        var $labels_array {
          value = $input.labels|split:","
        }
        var $trimmed_labels {
          value = $labels_array|map:"trim"
        }
        var.update $payload {
          value = $payload|set:"labels":$trimmed_labels
        }
      }
    }

    // Add assignees if provided
    conditional {
      if ($input.assignees != null && $input.assignees != "") {
        var $assignees_array {
          value = $input.assignees|split:","
        }
        var $trimmed_assignees {
          value = $assignees_array|map:"trim"
        }
        var.update $payload {
          value = $payload|set:"assignees":$trimmed_assignees
        }
      }
    }

    // Build the API URL
    var $api_url {
      value = "https://api.github.com/repos/" ~ $input.owner ~ "/" ~ $input.repo ~ "/issues"
    }

    // Send the request to GitHub
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Accept: application/vnd.github+json",
        "Authorization: Bearer " ~ $api_key,
        "X-GitHub-Api-Version: 2022-11-28"
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $issue_number { value = null }
    var $issue_url { value = null }
    var $issue_html_url { value = null }
    var $issue_state { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $issue_number { value = $response_body|get:"number" }
        var $issue_url { value = $response_body|get:"url" }
        var $issue_html_url { value = $response_body|get:"html_url" }
        var $issue_state { value = $response_body|get:"state" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "GitHub API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"message" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj
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
    issue_number: $issue_number,
    issue_url: $issue_url,
    issue_html_url: $issue_html_url,
    state: $issue_state,
    error: $error_message
  }
}
