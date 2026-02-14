function "send_slack_message" {
  input {
    text channel
    text message
  }
  stack {
    // Validate required inputs
    precondition ($input.channel != null && $input.channel != "") {
      error_type = "inputerror"
      error = "Channel is required"
    }
    
    precondition ($input.message != null && $input.message != "") {
      error_type = "inputerror"
      error = "Message is required"
    }

    // Validate environment variable is set
    precondition ($env.SLACK_BOT_TOKEN != null && $env.SLACK_BOT_TOKEN != "") {
      error_type = "standard"
      error = "SLACK_BOT_TOKEN environment variable is required"
    }

    // Build the Slack API request payload
    var $payload {
      value = {
        channel: $input.channel,
        text: $input.message
      }
    }

    // Send message to Slack via chat.postMessage API
    api.request {
      url = "https://slack.com/api/chat.postMessage"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.SLACK_BOT_TOKEN
      ]
      timeout = 30
    } as $slack_response

    // Check if the API call was successful
    precondition ($slack_response.response.status >= 200 && $slack_response.response.status < 300) {
      error_type = "standard"
      error = "Slack API HTTP error: " ~ ($slack_response.response.status|to_text)
    }

    // Extract the response body
    var $response_body { value = $slack_response.response.result }

    // Check if Slack API returned ok: true
    conditional {
      if ($response_body.ok != true) {
        throw {
          name = "SlackAPIError"
          value = "Slack API error: " ~ ($response_body.error ?? "Unknown error")
        }
      }
    }

    // Build success response
    var $result {
      value = {
        success: true,
        channel: $response_body.channel,
        timestamp: $response_body.ts,
        message: "Message sent successfully to " ~ $input.channel
      }
    }
  }
  response = $result
}
