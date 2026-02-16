function "create_auth0_user" {
  description = "Create a new user in Auth0"
  input {
    text email
    text password
    text connection = "Username-Password-Authentication"
    json user_metadata?
    json app_metadata?
  }
  stack {
    var $api_url {
      value = "https://" ~ $env.auth0_domain ~ "/api/v2/users"
    }

    var $access_token_url {
      value = "https://" ~ $env.auth0_domain ~ "/oauth/token"
    }

    var $token_payload {
      value = {
        grant_type: "client_credentials"
        client_id: $env.auth0_client_id
        client_secret: $env.auth0_client_secret
        audience: "https://" ~ $env.auth0_domain ~ "/api/v2/"
      }
    }

    api.request {
      url = $access_token_url
      method = "POST"
      params = $token_payload
      headers = ["Content-Type: application/json"]
    } as $token_response

    precondition ($token_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to obtain Auth0 access token"
    }

    var $access_token {
      value = $token_response.response.result.access_token
    }

    var $user_payload {
      value = {
        email: $input.email
        password: $input.password
        connection: $input.connection
      }
    }

    conditional {
      if (`$input.user_metadata != null`) {
        var $user_payload {
          value = ($user_payload|set:"user_metadata":$input.user_metadata)
        }
      }
    }

    conditional {
      if (`$input.app_metadata != null`) {
        var $user_payload {
          value = ($user_payload|set:"app_metadata":$input.app_metadata)
        }
      }
    }

    api.request {
      url = $api_url
      method = "POST"
      params = $user_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
    } as $create_response

    precondition ($create_response.response.status == 201) {
      error_type = "standard"
      error = "Failed to create Auth0 user"
    }

    var $result {
      value = $create_response.response.result
    }
  }
  response = $result
}
