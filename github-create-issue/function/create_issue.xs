function "create_issue" {
  description = "Create a GitHub issue in a repository"
  input {
  }
  stack {
    // Get configuration from environment variables
    var $token {
      value = $env.github_token
    }
    var $owner {
      value = $env.github_owner
    }
    var $repo {
      value = $env.github_repo
    }
    var $title {
      value = $env.github_issue_title
    }
    var $body {
      value = $env.github_issue_body
    }

    // Validate required fields with preconditions for cleaner error handling
    var $validation_error {
      value = null
    }

    conditional {
      if ($token == null) {
        var.update $validation_error {
          value = "github_token is required"
        }
      }
    }

    conditional {
      if ($validation_error == null && $owner == null) {
        var.update $validation_error {
          value = "github_owner is required"
        }
      }
    }

    conditional {
      if ($validation_error == null && $repo == null) {
        var.update $validation_error {
          value = "github_repo is required"
        }
      }
    }

    conditional {
      if ($validation_error == null && $title == null) {
        var.update $validation_error {
          value = "github_issue_title is required"
        }
      }
    }

    // Check if validation failed
    conditional {
      if ($validation_error != null) {
        var $result {
          value = {
            status: "error",
            message: $validation_error
          }
        }
      }
      else {
        // Build the GitHub API URL
        var $github_url {
          value = "https://api.github.com/repos/" ~ $owner ~ "/" ~ $repo ~ "/issues"
        }

        // Create Authorization header
        var $auth_header {
          value = "Authorization: Bearer " ~ $token
        }

        // Prepare request body
        var $request_body {
          value = {
            title: $title
          }
        }

        // Add body if provided
        conditional {
          if ($body != null) {
            var.update $request_body {
              value = {
                title: $title,
                body: $body
              }
            }
          }
        }

        // Make the API request to GitHub
        api.request {
          url = $github_url
          method = "POST"
          params = $request_body
          headers = [
            "Accept: application/vnd.github+json",
            "X-GitHub-Api-Version: 2022-11-28",
            $auth_header
          ]
          timeout = 30
        } as $api_result

        // Check if the request was successful
        var $http_status {
          value = $api_result.response.status
        }

        conditional {
          if ($http_status == 201) {
            // Issue created successfully
            var $response_data {
              value = $api_result.response.result
            }
            var $result {
              value = {
                status: "success",
                message: "Issue created successfully",
                issue_number: $response_data.number,
                issue_id: $response_data.id,
                issue_url: $response_data.html_url,
                title: $response_data.title,
                state: $response_data.state,
                created_at: $response_data.created_at,
                github_response: $response_data
              }
            }
          }
          else {
            // Handle error
            var $response_data {
              value = $api_result.response.result
            }
            var $status_text {
              value = $api_result.response.status|to_text
            }
            var $error_message {
              value = ($response_data.message != null) ? $response_data.message : "Unknown error"
            }
            var $result {
              value = {
                status: "error",
                message: "Failed to create issue. Status: " ~ $status_text ~ ", Error: " ~ $error_message,
                github_response: $response_data
              }
            }
          }
        }
      }
    }
  }
  response = $result
}