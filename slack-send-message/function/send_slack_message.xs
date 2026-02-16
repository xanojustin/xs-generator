function "send_slack_message" {
  description = "Send a message to a Slack channel using the Slack Web API"
  input {
    text channel filters=trim
    text message filters=trim
  }
  stack {
    // Get Slack token from environment
    var $slack_token { value = $env.SLACK_BOT_TOKEN }
    
    // Validate inputs
    precondition ($input.channel != "") {
      error_type = "inputerror"
      error = "Slack channel is required"
    }
    
    precondition ($input.message != "") {
      error_type = "inputerror"
      error = "Message text is required"
    }
    
    precondition ($slack_token != "") {
      error_type = "inputerror"
      error = "SLACK_BOT_TOKEN environment variable is required"
    }
    
    // Prepare the request payload
    var $payload {
      value = {
        channel: $input.channel,
        text: $input.message
      }
    }
    
    // Make the API request to Slack
    api.request {
      url = "https://slack.com/api/chat.postMessage"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $slack_token
      ]
      timeout = 30
    } as $slack_response
    
    // Check if the request was successful
    conditional {
      if ($slack_response.response.status != 200) {
        throw {
          name = "SlackAPIError"
          value = "Slack API returned HTTP " ~ ($slack_response.response.status|to_text)
        }
      }
    }
    
    // Check Slack's response for API-level errors
    var $response_body { value = $slack_response.response.result }
    
    conditional {
      if ($response_body.ok == false) {
        var $error_msg {
          value = "Slack API error: " ~ ($response_body.error ?? "Unknown error")
        }
        throw {
          name = "SlackAPIError"
          value = $error_msg
        }
      }
    }
    
    // Build success response
    var $result {
      value = {
        success: true,
        channel: $response_body.channel,
        timestamp: $response_body.ts,
        message_text: $response_body.message.text
      }
    }
  }
  response = $result
}
