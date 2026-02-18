function "create_okta_user" {
  input {
    text first_name filters=trim
    text last_name filters=trim
    email email filters=trim
    text login filters=trim
    text mobile_phone? filters=trim
    bool activate?=true
  }

  stack {
    // Validate required environment variables
    precondition ($env.OKTA_ORG_URL != null && $env.OKTA_ORG_URL != "") {
      error_type = "standard"
      error = "OKTA_ORG_URL environment variable is required"
    }

    precondition ($env.OKTA_API_TOKEN != null && $env.OKTA_API_TOKEN != "") {
      error_type = "standard"
      error = "OKTA_API_TOKEN environment variable is required"
    }

    // Build user profile
    var $profile {
      value = {
        firstName: $input.first_name
        lastName: $input.last_name
        email: $input.email
        login: $input.login
      }
    }

    // Add mobile phone if provided
    conditional {
      if ($input.mobile_phone != null && $input.mobile_phone != "") {
        var.update $profile {
          value = $profile|set:"mobilePhone":$input.mobile_phone
        }
      }
    }

    // Build request payload
    var $payload {
      value = {
        profile: $profile
      }
    }

    // Make Okta API request to create user
    api.request {
      url = ($env.OKTA_ORG_URL|trim) ~ "/api/v1/users"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
        "Accept: application/json"
        "Authorization: SSWS " ~ $env.OKTA_API_TOKEN
      ]
      timeout = 30
    } as $api_result

    // Handle API response
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        // User created successfully
        var $user_id { value = $api_result.response.result.id }
        var $user_status { value = $api_result.response.result.status }
        var $created_at { value = $api_result.response.result.created }

        // Log success
        debug.log {
          value = "Okta user created successfully: " ~ $user_id
        }

        // Build success response
        var $result {
          value = {
            success: true
            user_id: $user_id
            status: $user_status
            login: $input.login
            email: $input.email
            created_at: $created_at
            message: "User created successfully in Okta"
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request - validation error
        throw {
          name = "OktaValidationError"
          value = "Invalid user data: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized
        throw {
          name = "OktaAuthError"
          value = "Invalid Okta API token or insufficient permissions"
        }
      }
      elseif ($api_result.response.status == 409) {
        // Conflict - user already exists
        throw {
          name = "OktaConflictError"
          value = "User with login '" ~ $input.login ~ "' already exists in Okta"
        }
      }
      elseif ($api_result.response.status == 429) {
        // Rate limited
        throw {
          name = "OktaRateLimitError"
          value = "Okta API rate limit exceeded. Please try again later."
        }
      }
      else {
        // Other errors
        throw {
          name = "OktaAPIError"
          value = "Okta API error (status " ~ ($api_result.response.status|to_text) ~ "): " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }

  response = $result
}
