function "trigger_event" {
  description = "Trigger a real-time event on Pusher Channels"
  input {
    text channel filters=trim { description = "Channel name to publish to (e.g., 'my-channel')" }
    text event filters=trim { description = "Event name (e.g., 'my-event')" }
    text message filters=trim { description = "Message payload to send" }
  }

  stack {
    // Get environment variables
    var $app_id { value = $env.PUSHER_APP_ID }
    var $key { value = $env.PUSHER_KEY }
    var $secret { value = $env.PUSHER_SECRET }
    var $cluster { value = $env.PUSHER_CLUSTER }

    // Validate all environment variables are configured
    precondition ($app_id != null && $app_id != "") {
      error_type = "standard"
      error = "PUSHER_APP_ID environment variable not configured"
    }

    precondition ($key != null && $key != "") {
      error_type = "standard"
      error = "PUSHER_KEY environment variable not configured"
    }

    precondition ($secret != null && $secret != "") {
      error_type = "standard"
      error = "PUSHER_SECRET environment variable not configured"
    }

    precondition ($cluster != null && $cluster != "") {
      error_type = "standard"
      error = "PUSHER_CLUSTER environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.channel != null && $input.channel != "") {
      error_type = "inputerror"
      error = "Channel name is required"
    }

    precondition ($input.event != null && $input.event != "") {
      error_type = "inputerror"
      error = "Event name is required"
    }

    // Build the request payload
    var $payload {
      value = {
        name: $input.event,
        channel: $input.channel,
        data: $input.message
      }
    }

    // Build the API URL
    var $api_url {
      value = "https://api-" ~ $cluster ~ ".pusher.com/apps/" ~ $app_id ~ "/events"
    }

    // Create Basic Auth header (key:secret base64 encoded)
    var $auth_string {
      value = $key ~ ":" ~ $secret
    }
    var $auth_base64 {
      value = $auth_string|base64_encode
    }
    var $auth_header {
      value = "Authorization: Basic " ~ $auth_base64
    }

    // Send the request to Pusher
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        $auth_header
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $event_id { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        conditional {
          if ($response_body != null) {
            var $event_id { value = $response_body|get:"event_id" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Pusher API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $response_body { value = $api_result.response.result }
            var $error_msg { value = $response_body|get:"message" }
            conditional {
              if ($error_msg != null && $error_msg != "") {
                var $error_message { value = $error_msg }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    event_id: $event_id,
    channel: $input.channel,
    event: $input.event,
    error: $error_message
  }
}
