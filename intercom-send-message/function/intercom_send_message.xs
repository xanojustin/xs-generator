function "intercom_send_message" {
  description = "Send a message to a user via Intercom API"
  input {
    text user_id filters=trim
    text message_body filters=trim
    text message_type?="email"
  }
  stack {
    // Validate required inputs
    precondition ($input.user_id != null && $input.user_id != "") {
      error_type = "inputerror"
      error = "user_id is required"
    }

    precondition ($input.message_body != null && $input.message_body != "") {
      error_type = "inputerror"
      error = "message_body is required"
    }

    // Get API key from environment
    var $api_key { value = $env.INTERCOM_ACCESS_TOKEN }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "INTERCOM_ACCESS_TOKEN environment variable is required"
    }

    // Build the request payload for sending a message
    var $payload {
      value = {
        message_type: $input.message_type,
        body: $input.message_body,
        from: {
          type: "admin",
          id: $env.INTERCOM_ADMIN_ID ?? ""
        },
        to: {
          type: "user",
          id: $input.user_id
        }
      }
    }

    // Make the API request to Intercom
    api.request {
      url = "https://api.intercom.io/messages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key,
        "Accept: application/json"
      ]
      timeout = 30
    } as $api_result

    // Check response status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_data { value = $api_result.response.result }
        var $success {
          value = {
            success: true,
            message_id: $response_data.id ?? "",
            created_at: $response_data.created_at ?? now
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid Intercom access token"
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFoundError"
          value = "User not found in Intercom"
        }
      }
      else {
        var $error_body { value = $api_result.response.result }
        throw {
          name = "IntercomAPIError"
          value = "Intercom API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($error_body|json_encode)
        }
      }
    }
  }
  response = $success
}
