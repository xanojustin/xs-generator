function "send_discord_message" {
  input {
    text content
    text? username
    text? avatar_url
  }
  stack {
    // Validate webhook URL is configured
    precondition (($env.DISCORD_WEBHOOK_URL|strlen) > 0) {
      error_type = "standard"
      error = "DISCORD_WEBHOOK_URL environment variable is required"
    }

    // Build the payload
    var $payload { 
      value = {
        content: $input.content
      }
    }

    // Add optional username if provided
    conditional {
      if (`$input.username|strlen > 0`) {
        var $payload {
          value = $payload|merge:{
            username: $input.username
          }
        }
      }
    }

    // Add optional avatar_url if provided
    conditional {
      if (`$input.avatar_url|strlen > 0`) {
        var $payload {
          value = $payload|merge:{
            avatar_url: $input.avatar_url
          }
        }
      }
    }

    // Send the webhook request to Discord
    api.request {
      url = $env.DISCORD_WEBHOOK_URL
      method = "POST"
      headers = ["Content-Type: application/json"]
      params = $payload
      timeout = 30
    } as $discord_response

    // Check if the request was successful
    precondition (($discord_response.response.status >= 200) && ($discord_response.response.status < 300)) {
      error_type = "standard"
      error = "Discord webhook failed with status: " ~ ($discord_response.response.status|to_text)
    }
  }
  response = {
    success: true,
    status: $discord_response.response.status,
    message: "Message sent to Discord successfully"
  }
}
