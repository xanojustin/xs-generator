function "trigger_vercel_deployment" {
  input {
    text project_id
    text? team_id
    text? target
  }
  stack {
    // Validate required inputs
    precondition ($input.project_id != null && $input.project_id != "") {
      error_type = "inputerror"
      error = "project_id is required"
    }

    // Set default target if not provided
    var $deployment_target { value = "production" }
    conditional {
      if ($input.target != null && $input.target != "") {
        var.update $deployment_target { value = $input.target }
      }
    }

    // Build the API URL with optional team_id
    var $base_url { value = "https://api.vercel.com/v13/deployments" }
    var $url { value = $base_url }
    conditional {
      if ($input.team_id != null && $input.team_id != "") {
        var.update $url { value = $base_url ~ "?teamId=" ~ $input.team_id }
      }
    }

    // Build the request payload
    var $payload {
      value = {
        target: $deployment_target
        project: $input.project_id
      }
    }

    // Make the API request to Vercel
    api.request {
      url = $url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
        "Authorization: Bearer " ~ $env.vercel_api_token
      ]
      timeout = 60
    } as $api_result

    // Handle the response
    var $result { value = {} }
    conditional {
      if ($api_result.response.status == 200) {
        // Success - deployment created
        var $deployment { value = $api_result.response.result }
        var $success_response {
          value = {
            success: true
            deployment_id: $deployment.id
            url: $deployment.url
            state: $deployment.state
            created_at: $deployment.createdAt
            project_id: $input.project_id
            target: $deployment_target
          }
        }
        var.update $result { value = $success_response }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized - invalid token
        throw {
          name = "AuthenticationError"
          value = "Invalid Vercel API token. Please check your vercel_api_token environment variable."
        }
      }
      elseif ($api_result.response.status == 403) {
        // Forbidden - insufficient permissions
        throw {
          name = "PermissionError"
          value = "Insufficient permissions to deploy this project. Ensure your API token has access to the project."
        }
      }
      elseif ($api_result.response.status == 404) {
        // Not found - project doesn't exist
        throw {
          name = "NotFoundError"
          value = "Project not found. Please check your project_id and team_id."
        }
      }
      elseif ($api_result.response.status == 429) {
        // Rate limited
        throw {
          name = "RateLimitError"
          value = "Vercel API rate limit exceeded. Please try again later."
        }
      }
      else {
        // Other errors
        throw {
          name = "VercelAPIError"
          value = "Vercel API error (HTTP " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $result
}
