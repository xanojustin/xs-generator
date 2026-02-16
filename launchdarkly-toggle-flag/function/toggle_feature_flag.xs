function "toggle_feature_flag" {
  input {
    text flag_key
    text environment_key
    bool enabled
  }
  stack {
    // Validate required inputs
    precondition ($input.flag_key != null && $input.flag_key != "") {
      error_type = "inputerror"
      error = "flag_key is required"
    }

    precondition ($input.environment_key != null && $input.environment_key != "") {
      error_type = "inputerror"
      error = "environment_key is required"
    }

    // Build the API URL for toggling the feature flag
    var $api_url {
      value = "https://app.launchdarkly.com/api/v2/flags/" ~ $env.launchdarkly_project_key ~ "/" ~ $input.flag_key
    }

    // Build the request payload to update the flag
    var $payload {
      value = {
        environments: {
          $input.environment_key: {
            on: $input.enabled
          }
        }
      }
    }

    // Make the API request to LaunchDarkly
    api.request {
      url = $api_url
      method = "PATCH"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: " ~ $env.launchdarkly_api_key
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $flag_data { value = $api_result.response.result }
        var $job_result {
          value = {
            success: true,
            flag_key: $input.flag_key,
            environment: $input.environment_key,
            enabled: $input.enabled,
            name: $flag_data.name,
            description: $flag_data.description,
            maintainer: $flag_data.maintainer
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid LaunchDarkly API key"
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFoundError"
          value = "Feature flag not found in project"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "LaunchDarkly API returned status " ~ ($api_result.response.status|to_text)
        }
      }
    }
  }
  response = $job_result
}
