function "klaviyo_create_profile" {
  description = "Create or update a profile in Klaviyo. Uses the profile-import endpoint for efficient bulk-style operations."

  input {
    email email {
      description = "User's email address (required)"
      sensitive = false
    }

    text first_name? filters=trim {
      description = "User's first name"
      sensitive = false
    }

    text last_name? filters=trim {
      description = "User's last name"
      sensitive = false
    }

    text phone? filters=trim {
      description = "User's phone number"
      sensitive = false
    }

    text external_id? filters=trim {
      description = "External ID from your system"
      sensitive = false
    }

    json custom_properties? {
      description = "Custom profile properties as JSON object"
      sensitive = false
    }
  }

  stack {
    var $klaviyo_base_url {
      description = "Klaviyo API base URL from environment"
      value = $env.KLAVIYO_BASE_URL
    }

    var $api_key {
      description = "Klaviyo API key from environment"
      value = $env.KLAVIYO_API_KEY
    }

    precondition ($klaviyo_base_url != null && $klaviyo_base_url != "") {
      description = "Validate KLAVIYO_BASE_URL environment variable is set"
      error_type = "standard"
      error = "KLAVIYO_BASE_URL environment variable is not configured"
    }

    precondition ($api_key != null && $api_key != "") {
      description = "Validate KLAVIYO_API_KEY environment variable is set"
      error_type = "standard"
      error = "KLAVIYO_API_KEY environment variable is not configured"
    }

    var $profile_data {
      description = "Build the profile data object"
      value = {
        data: {
          type: "profile",
          attributes: {
            email: $input.email
          }
        }
      }
    }

    conditional {
      description = "Add first_name to profile if provided"
      if ($input.first_name != null && $input.first_name != "") {
        var.update $profile_data {
          value = $profile_data|set:"data":($profile_data.data|set:"attributes":($profile_data.data.attributes|set:"first_name":$input.first_name))
        }
      }
    }

    conditional {
      description = "Add last_name to profile if provided"
      if ($input.last_name != null && $input.last_name != "") {
        var.update $profile_data {
          value = $profile_data|set:"data":($profile_data.data|set:"attributes":($profile_data.data.attributes|set:"last_name":$input.last_name))
        }
      }
    }

    conditional {
      description = "Add phone to profile if provided"
      if ($input.phone != null && $input.phone != "") {
        var.update $profile_data {
          value = $profile_data|set:"data":($profile_data.data|set:"attributes":($profile_data.data.attributes|set:"phone_number":$input.phone))
        }
      }
    }

    conditional {
      description = "Add external_id to profile if provided"
      if ($input.external_id != null && $input.external_id != "") {
        var.update $profile_data {
          value = $profile_data|set:"data":($profile_data.data|set:"attributes":($profile_data.data.attributes|set:"external_id":$input.external_id))
        }
      }
    }

    conditional {
      description = "Add custom properties to profile if provided"
      if ($input.custom_properties != null) {
        var.update $profile_data {
          value = $profile_data|set:"data":($profile_data.data|set:"attributes":($profile_data.data.attributes|set:"properties":$input.custom_properties))
        }
      }
    }

    var $request_url {
      description = "Build the Klaviyo profile-import API URL"
      value = $klaviyo_base_url ~ "/profile-import/"
    }

    debug.log {
      description = "Log profile creation attempt"
      value = {
        action: "klaviyo_create_profile",
        email: $input.email,
        url: $request_url
      }
    }

    api.request {
      description = "Send profile data to Klaviyo API"
      url = $request_url
      method = "POST"
      headers = []|push:"Authorization: Klaviyo-API-Key " ~ $api_key|push:"Content-Type: application/json"|push:"revision: 2025-01-15"
      params = $profile_data
      timeout = 30
    } as $api_response

    var $success {
      description = "Determine if the API call was successful"
      value = $api_response.status_code >= 200 && $api_response.status_code < 300
    }

    var $profile_id {
      description = "Extract Klaviyo profile ID from response"
      value = ""
    }

    conditional {
      description = "Extract profile ID if response contains data"
      if ($success && $api_response.response.data != null) {
        var.update $profile_id {
          value = $api_response.response.data.id
        }
      }
    }

    debug.log {
      description = "Log profile creation result"
      value = {
        action: "klaviyo_create_profile_complete",
        email: $input.email,
        success: $success,
        profile_id: $profile_id,
        status_code: $api_response.status_code
      }
    }

    var $result {
      description = "Build the function result"
      value = {
        success: $success,
        profile_id: $profile_id,
        response: $api_response.response
      }
    }
  }

  response = $result
}
