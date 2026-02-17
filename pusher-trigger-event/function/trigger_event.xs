function "trigger_event" {
  input {
    text channel
    text event_name
    json data
    text socket_id?
  }

  stack {
    // Build the request payload
    var $payload {
      value = {
        name: $input.event_name,
        channel: $input.channel,
        data: $input.data|json_encode
      }
    }

    // Add socket_id if provided (for excluding sender)
    conditional {
      if ($input.socket_id != null && $input.socket_id != "") {
        var.update $payload {
          value = $payload|set:"socket_id":$input.socket_id
        }
      }
    }

    // Make the request to Pusher REST API
    api.request {
      url = "https://api-eu.pusher.com/apps/" ~ $env.PUSHER_APP_ID ~ "/events"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.PUSHER_KEY ~ ":" ~ $env.PUSHER_SECRET
      ]
      timeout = 30
    } as $api_result

    // Check for success
    conditional {
      if ($api_result.response.status == 200) {
        var $result {
          value = {
            success: true,
            message: "Event triggered successfully",
            channel: $input.channel,
            event: $input.event_name,
            response: $api_result.response.result
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            error: "Failed to trigger event",
            status_code: $api_result.response.status,
            response: $api_result.response.result
          }
        }
      }
    }
  }

  response = $result
}
