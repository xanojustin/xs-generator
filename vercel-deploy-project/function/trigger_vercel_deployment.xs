function "trigger_vercel_deployment" {
  input {
    text project_id
    text team_id?=""
    text target?="production"
  }

  stack {
    // Validate required inputs
    precondition ($input.project_id != null && $input.project_id != "") {
      error_type = "inputerror"
      error = "project_id is required"
    }

    // Validate target is either production or preview
    precondition ($input.target == "production" || $input.target == "preview") {
      error_type = "inputerror"
      error = "target must be 'production' or 'preview'"
    }

    // Build the deployment payload
    var $deploy_payload {
      value = {
        target: $input.target,
        name: $input.project_id
      }
    }

    // Build query parameters for team
    var $query_params {
      value = ""
    }
    conditional {
      if ($input.team_id != null && $input.team_id != "") {
        var.update $query_params { value = "?teamId=" ~ $input.team_id }
      }
    }

    // Trigger the deployment via Vercel API
    api.request {
      url = "https://api.vercel.com/v13/deployments" ~ $query_params
      method = "POST"
      params = $deploy_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.vercel_api_token
      ]
      timeout = 60
    } as $deploy_response

    // Check if deployment was created successfully
    conditional {
      if ($deploy_response.response.status == 200 || $deploy_response.response.status == 201) {
        var $deployment_id { value = $deploy_response.response.result.id }
        var $deployment_url { value = $deploy_response.response.result.url }
        var $deployment_state { value = $deploy_response.response.result.readyState }

        // Poll for deployment status until complete or failed
        var $max_attempts { value = 30 }
        var $attempt { value = 0 }
        var $is_complete { value = false }

        while ($attempt < $max_attempts && !$is_complete) {
          each {
            // Wait between polls (simulate with delay logic via retries)
            var.update $attempt { value = $attempt + 1 }

            // Check deployment status
            api.request {
              url = "https://api.vercel.com/v13/deployments/" ~ $deployment_id ~ $query_params
              method = "GET"
              headers = [
                "Authorization: Bearer " ~ $env.vercel_api_token
              ]
              timeout = 30
            } as $status_response

            conditional {
              if ($status_response.response.status == 200) {
                var.update $deployment_state { value = $status_response.response.result.readyState }

                // Check if deployment is complete
                conditional {
                  if ($deployment_state == "READY") {
                    var.update $is_complete { value = true }
                    var $final_url { value = $status_response.response.result.alias|first }
                    conditional {
                      if ($final_url == null || $final_url == "") {
                        var.update $final_url { value = $deployment_url }
                      }
                    }
                  }
                  elseif ($deployment_state == "ERROR" || $deployment_state == "CANCELED") {
                    var.update $is_complete { value = true }
                  }
                }
              }
            }
          }
        }

        // Build final response
        var $result {
          value = {
            success: ($deployment_state == "READY"),
            deployment_id: $deployment_id,
            url: $final_url ?? $deployment_url,
            state: $deployment_state,
            project_id: $input.project_id,
            target: $input.target,
            polled_attempts: $attempt
          }
        }
      }
      else {
        // Handle deployment creation failure
        var $error_message { value = "Failed to create deployment" }
        conditional {
          if ($deploy_response.response.result.error != null) {
            var.update $error_message { value = $deploy_response.response.result.error.message }
          }
        }

        throw {
          name = "VercelAPIError"
          value = $error_message
        }
      }
    }
  }

  response = $result
}
