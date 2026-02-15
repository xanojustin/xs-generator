// Okta Create User - Creates a user in Okta via the Users API
// API Reference: https://developer.okta.com/docs/reference/api/users/
function "create_okta_user" {
  description = "Create a new user in Okta with profile and optional credentials"
  
  input {
    text first_name filters=trim
    text last_name filters=trim
    email email filters=lower
    text? login
    bool activate?=true
    text? mobile_phone
    text? password
  }
  
  stack {
    // Use email as login if not provided
    var $user_login {
      value = $input.login ?? $input.email
    }
    
    // Build the profile object
    var $profile {
      value = {
        firstName: $input.first_name,
        lastName: $input.last_name,
        email: $input.email,
        login: $user_login
      }
    }
    
    // Add optional mobile phone if provided
    conditional {
      if ($input.mobile_phone != null && $input.mobile_phone != "") {
        var.update $profile {
          value = $profile|set:"mobilePhone":$input.mobile_phone
        }
      }
    }
    
    // Build the request payload
    var $payload {
      value = {
        profile: $profile
      }
    }
    
    // Add credentials if password is provided
    conditional {
      if ($input.password != null && $input.password != "") {
        var $credentials {
          value = {
            password: {
              value: $input.password
            }
          }
        }
        var.update $payload {
          value = $payload|set:"credentials":$credentials
        }
      }
    }
    
    // Build the Okta API URL
    var $api_url {
      value = "https://" ~ $env.OKTA_DOMAIN ~ "/api/v1/users"
    }
    
    // Make the API request to Okta
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Accept: application/json",
        "Authorization: SSWS " ~ $env.OKTA_API_TOKEN
      ]
      timeout = 30
    } as $api_result
    
    // Handle the response
    conditional {
      if ($api_result.response.status == 200) {
        // User created successfully (active)
        var $result {
          value = {
            success: true,
            user_id: $api_result.response.result.id,
            status: $api_result.response.result.status,
            created: $api_result.response.result.created,
            activated: $api_result.response.result.activated,
            profile: $api_result.response.result.profile,
            message: "User created successfully"
          }
        }
      }
      elseif ($api_result.response.status == 201) {
        // User created successfully (pending activation or staged)
        var $result {
          value = {
            success: true,
            user_id: $api_result.response.result.id,
            status: $api_result.response.result.status,
            created: $api_result.response.result.created,
            activated: $api_result.response.result.activated,
            profile: $api_result.response.result.profile,
            message: "User created successfully"
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request - validation error
        throw {
          name = "ValidationError"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized
        throw {
          name = "AuthenticationError"
          value = "Invalid Okta API token or insufficient permissions"
        }
      }
      elseif ($api_result.response.status == 409) {
        // Conflict - user already exists
        throw {
          name = "ConflictError"
          value = "User with this login or email already exists"
        }
      }
      elseif ($api_result.response.status == 429) {
        // Rate limited
        throw {
          name = "RateLimitError"
          value = "Okta API rate limit exceeded. Please try again later."
        }
      }
      else {
        // Other errors
        throw {
          name = "OktaAPIError"
          value = "Okta API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $result
}
