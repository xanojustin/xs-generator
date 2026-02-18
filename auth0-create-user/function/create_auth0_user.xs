function "create_auth0_user" {
  description = "Create a new user in Auth0 with email, password, and optional metadata"
  input {
    email email {
      description = "User's email address (will be used as username)"
    }
    text password {
      description = "User's password (must meet Auth0 password policy)"
    }
    text? connection?="Username-Password-Authentication" {
      description = "Auth0 connection/database name"
    }
    bool? verify_email?=true {
      description = "Whether to send a verification email"
    }
    json? user_metadata {
      description = "Optional custom metadata for the user"
    }
    json? app_metadata {
      description = "Optional app-specific metadata (read-only in client)"
    }
  }

  stack {
    // Validate required environment variables
    precondition ($env.AUTH0_DOMAIN != "" && $env.AUTH0_DOMAIN != null) {
      error_type = "standard"
      error = "AUTH0_DOMAIN environment variable is required"
    }
    
    precondition ($env.AUTH0_MANAGEMENT_TOKEN != "" && $env.AUTH0_MANAGEMENT_TOKEN != null) {
      error_type = "standard"
      error = "AUTH0_MANAGEMENT_TOKEN environment variable is required"
    }

    // Build the request payload - only include non-null optional fields
    var $payload {
      value = {
        email: $input.email,
        password: $input.password,
        connection: $input.connection,
        verify_email: $input.verify_email
      }
    }

    // Add optional metadata fields if provided
    conditional {
      if ($input.user_metadata != null) {
        var $payload_with_user_meta {
          value = $payload ~ { user_metadata: $input.user_metadata }
        }
        var.update $payload { value = $payload_with_user_meta }
      }
    }

    conditional {
      if ($input.app_metadata != null) {
        var $payload_with_app_meta {
          value = $payload ~ { app_metadata: $input.app_metadata }
        }
        var.update $payload { value = $payload_with_app_meta }
      }
    }

    // Make the API request to Auth0 Management API
    api.request {
      url = "https://" ~ $env.AUTH0_DOMAIN ~ "/api/v2/users"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.AUTH0_MANAGEMENT_TOKEN
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status == 201 || $api_result.response.status == 200) {
      error_type = "standard"
      error = "Auth0 API error: " ~ ($api_result.response.result|json_encode)
    }

    // Extract user data from response
    var $user_data {
      value = $api_result.response.result
    }

    // Log success (debug level - won't show in production)
    debug.log {
      value = "Successfully created Auth0 user: " ~ $user_data.user_id
    }
  }

  response = {
    success: true,
    user_id: $user_data.user_id,
    email: $user_data.email,
    email_verified: $user_data.email_verified,
    created_at: $user_data.created_at,
    connection: $user_data.connection,
    user_metadata: $user_data.user_metadata,
    app_metadata: $user_data.app_metadata
  }
}
