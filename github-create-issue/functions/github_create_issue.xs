function "github_create_issue" {
  description = "Create a new issue in a GitHub repository via the GitHub API"
  
  input {
    text repo_owner filters=trim {
      description = "GitHub username or organization that owns the repository"
    }
    
    text repo_name filters=trim {
      description = "Name of the repository"
    }
    
    text title filters=trim {
      description = "Title of the issue"
    }
    
    text body? filters=trim {
      description = "Body content of the issue (Markdown supported)"
    }
    
    text labels_json? filters=trim {
      description = "JSON array of label names (e.g., '[\"bug\", \"help wanted\"]')"
    }
    
    text assignees_json? filters=trim {
      description = "JSON array of GitHub usernames (e.g., '[\"octocat\"]')"
    }
  }
  
  stack {
    precondition (($env.github_token|strlen) > 0) {
      error_type = "standard"
      error = "github_token environment variable is required"
    }
    
    precondition (($input.repo_owner|is_empty) == false) {
      error_type = "inputerror"
      error = "Repository owner is required"
    }

    precondition (($input.repo_name|is_empty) == false) {
      error_type = "inputerror"
      error = "Repository name is required"
    }

    precondition (($input.title|is_empty) == false) {
      error_type = "inputerror"
      error = "Issue title is required"
    }

    var $issue_body {
      description = "Build the GitHub API request payload"
      value = {
        title: $input.title
      }
    }

    conditional {
      description = "Add body if provided"
      if (($input.body|is_empty) == false) {
        var $issue_body {
          value = $issue_body|set:"body":$input.body
        }
      }
    }

    conditional {
      description = "Parse and add labels if provided"
      if (($input.labels_json|is_empty) == false) {
        var $labels {
          value = $input.labels_json|json_decode
        }
        var $issue_body {
          value = $issue_body|set:"labels":$labels
        }
      }
    }

    conditional {
      description = "Parse and add assignees if provided"
      if (($input.assignees_json|is_empty) == false) {
        var $assignees {
          value = $input.assignees_json|json_decode
        }
        var $issue_body {
          value = $issue_body|set:"assignees":$assignees
        }
      }
    }

    var $github_url {
      description = "Construct the GitHub API URL"
      value = "https://api.github.com/repos/" ~ $input.repo_owner ~ "/" ~ $input.repo_name ~ "/issues"
    }

    api.request {
      description = "Make the GitHub API call to create the issue"
      url = $github_url
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.github_token,
        "Accept: application/vnd.github+json",
        "X-GitHub-Api-Version: 2022-11-28",
        "Content-Type: application/json"
      ]
      params = $issue_body|json_encode
    } as $github_response

    var $response_status {
      description = "Extract HTTP status code"
      value = $github_response.response.status
    }

    precondition ($response_status == 201) {
      error_type = "standard"
      error = "GitHub API error (" ~ ($response_status|to_text) ~ "): " ~ ($github_response.response.body.message ?? "Unknown error")
    }

    var $issue_data {
      description = "Extract issue data from response"
      value = $github_response.response.body
    }
    
    var $result {
      description = "Build the response object"
      value = {
        success: true,
        issue_number: $issue_data.number,
        issue_url: $issue_data.html_url,
        issue_id: $issue_data.id,
        title: $issue_data.title,
        state: $issue_data.state,
        created_at: $issue_data.created_at
      }
    }
  }
  
  response = $result
}