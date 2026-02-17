function "create_firebase_user" {
  description = "Create a new user in Firebase Authentication via REST API"
  input {
    email email filters=lower { description = "User's email address" }
    text password filters=trim { description = "User's password (min 6 characters)" }
    text display_name? filters=trim { description = "Optional display name for the user" }
    bool email_verified? = false { description = "Whether the email is pre-verified" }
  }
  stack {
    // Validate password length (Firebase requires minimum 6 characters)
    precondition (($input.password|strlen) >= 6) {
      error_type = "inputerror"
      error = "Password must be at least 6 characters long"
    }

    // Build the Firebase Auth REST API URL
    // Using Firebase Auth REST API endpoint for sign up
    var $firebase_url {
      value = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" ~ $env.FIREBASE_API_KEY
    }

    // Prepare the request payload
    var $payload {
      value = {
        email: $input.email
        password: $input.password
        returnSecureToken: true
      }
    }

    // Make the API request to Firebase
    api.request {
      url = $firebase_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $firebase_response

    // Check for successful response
    conditional {
      if ($firebase_response.response.status == 200) {
        // Parse the response
        var $user_data { value = $firebase_response.response.result }
        
        // If display name was provided, update the user profile
        conditional {
          if ($input.display_name != null && $input.display_name != "") {
            var $profile_payload {
              value = {
                idToken: $user_data.idToken
                displayName: $input.display_name
                returnSecureToken: false
              }
            }
            
            api.request {
              url = "https://identitytoolkit.googleapis.com/v1/accounts:update?key=" ~ $env.FIREBASE_API_KEY
              method = "POST"
              params = $profile_payload
              headers = [
                "Content-Type: application/json"
              ]
              timeout = 30
            } as $profile_response
            
            conditional {
              if ($profile_response.response.status == 200) {
                var $updated_profile { value = $profile_response.response.result }
              }
            }
          }
        }
        
        // Build the success response
        var $result {
          value = {
            success: true
            user: {
              local_id: $user_data.localId
              email: $user_data.email
              display_name: $input.display_name ?? null
              email_verified: false
              created_at: now
            }
            tokens: {
              id_token: $user_data.idToken
              refresh_token: $user_data.refreshToken
              expires_in: $user_data.expiresIn
            }
          }
        }
      }
      elseif ($firebase_response.response.status == 400) {
        // Handle Firebase API errors
        var $error_data { value = $firebase_response.response.result }
        var $error_message {
          value = $error_data.error|get:"message" ?? "Invalid request to Firebase"
        }
        
        throw {
          name = "FirebaseAPIError"
          value = $error_message
        }
      }
      else {
        // Handle other errors
        throw {
          name = "FirebaseAPIError"
          value = "Firebase API returned status " ~ ($firebase_response.response.status|to_text)
        }
      }
    }
  }
  response = $result
}
