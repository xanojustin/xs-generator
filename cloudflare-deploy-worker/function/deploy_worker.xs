function "deploy_worker" {
  description = "Deploy a Cloudflare Worker script using the Cloudflare API"
  input {
    text script_name filters=trim
    text script_content
  }
  stack {
    // Validate required inputs
    precondition ($input.script_name != null && $input.script_name != "") {
      error_type = "inputerror"
      error = "script_name is required"
    }

    precondition ($input.script_content != null && $input.script_content != "") {
      error_type = "inputerror"
      error = "script_content is required"
    }

    // Get environment variables
    var $api_token { value = $env.cloudflare_api_token }
    var $account_id { value = $env.cloudflare_account_id }

    precondition ($api_token != null && $api_token != "") {
      error_type = "standard"
      error = "cloudflare_api_token environment variable is required"
    }

    precondition ($account_id != null && $account_id != "") {
      error_type = "standard"
      error = "cloudflare_account_id environment variable is required"
    }

    // Build the API URL for deploying a worker
    var $api_url {
      value = "https://api.cloudflare.com/client/v4/accounts/" ~ $account_id ~ "/workers/scripts/" ~ $input.script_name
    }

    // Prepare the multipart form data for the worker script
    // Cloudflare Workers API expects the script as form data with metadata
    var $metadata {
      value = {
        bindings: [],
        main_module: "index.js"
      }
    }

    // Make the API request to deploy the worker
    // Using PUT to upload the worker script
    api.request {
      url = $api_url
      method = "PUT"
      headers = [
        "Authorization: Bearer " ~ $api_token,
        "Content-Type: application/javascript"
      ]
      params = $input.script_content
      timeout = 60
    } as $api_result

    // Check for success (200 or 201 status codes)
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $deploy_result {
          value = {
            success: true,
            script_name: $input.script_name,
            message: "Worker deployed successfully",
            api_response: $api_result.response.result
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        throw {
          name = "BadRequest"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "Unauthorized"
          value = "Invalid API token or insufficient permissions"
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFound"
          value = "Account not found or Workers feature not enabled"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Cloudflare API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $deploy_result
}
