function "publish_message" {
  input {
    text channel
    text event_name
    json data
  }
  stack {
    // Validate required inputs
    precondition ($input.channel != null) {
      error_type = "inputerror"
      error = "Channel name is required"
    }

    precondition ($input.channel != "") {
      error_type = "inputerror"
      error = "Channel name cannot be empty"
    }

    precondition ($input.event_name != null) {
      error_type = "inputerror"
      error = "Event name is required"
    }

    precondition ($input.event_name != "") {
      error_type = "inputerror"
      error = "Event name cannot be empty"
    }

    precondition ($input.data != null) {
      error_type = "inputerror"
      error = "Message data is required"
    }

    // Build the Ably REST API URL
    var $ably_url {
      value = "https://rest.ably.io/channels/" ~ $input.channel ~ "/messages"
    }

    // Build the payload
    var $payload {
      value = {
        name: $input.event_name,
        data: $input.data
      }
    }

    // Make the API request to Ably
    api.request {
      url = $ably_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ $env.ABLY_API_KEY
      ]
      timeout = 30
    } as $api_result

    // Check for success (Ably returns 201 on successful publish)
    conditional {
      if ($api_result.response.status == 201) {
        var $result {
          value = {
            success: true,
            channel: $input.channel,
            event: $input.event_name,
            message_id: $api_result.response.result|get:"messageId",
            timestamp: now
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthorizationError"
          value = "Invalid Ably API key. Check your ABLY_API_KEY environment variable."
        }
      }
      elseif ($api_result.response.status == 400) {
        throw {
          name = "BadRequestError"
          value = "Invalid request"
        }
      }
      else {
        var $error_status {
          value = $api_result.response.status|to_text
        }
        throw {
          name = "APIError"
          value = "Ably API error"
        }
      }
    }
  }
  response = $result
}
