function "discord_webhook" {
  description = "Send a message to a Discord channel using a webhook URL"
  
  input {
    text message filters=trim
    text username?="Xano Bot" filters=trim
    text avatar_url?="" filters=trim
  }
  
  stack {
    // Validate message input
    precondition ($input.message != null && $input.message != "") {
      error_type = "inputerror"
      error = "Message content is required"
    }
    
    // Validate message length (Discord limit is 2000 characters for content)
    precondition (($input.message|strlen) <= 2000) {
      error_type = "inputerror"
      error = "Message exceeds Discord's 2000 character limit"
    }
    
    // Get webhook URL from environment
    var $webhook_url { value = $env.discord_webhook_url }
    
    // Validate environment variable
    precondition ($webhook_url != null && $webhook_url != "") {
      error_type = "standard"
      error = "Discord webhook URL is not configured. Set discord_webhook_url environment variable."
    }
    
    // Validate webhook URL format
    precondition ($webhook_url|starts_with:"https://discord.com/api/webhooks/") {
      error_type = "inputerror"
      error = "Invalid Discord webhook URL format. Expected: https://discord.com/api/webhooks/..."
    }
    
    // Build request payload
    var $payload { 
      value = {
        content: $input.message,
        username: $input.username
      }
    }
    
    // Add optional avatar_url if provided
    conditional {
      if ($input.avatar_url != null && $input.avatar_url != "") {
        var.update $payload { value = $payload|set:"avatar_url":$input.avatar_url }
      }
    }
    
    // Send webhook request to Discord
    api.request {
      url = $webhook_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
    } as $discord_response
    
    // Handle response
    conditional {
      if ($discord_response.response.status == 204) {
        // Success - Discord returns 204 No Content on success
        var $result { 
          value = {
            success: true,
            status: "sent",
            message: "Message sent to Discord successfully"
          }
        }
      }
      elseif ($discord_response.response.status == 400) {
        // Bad request - malformed JSON or invalid payload
        throw {
          name = "DiscordAPIError"
          value = "Invalid request: " ~ ($discord_response.response.result.message ?? "Check message format and length")
        }
      }
      elseif ($discord_response.response.status == 401) {
        // Unauthorized - invalid webhook token
        throw {
          name = "DiscordAPIError"
          value = "Invalid webhook URL or token. Please verify your discord_webhook_url environment variable."
        }
      }
      elseif ($discord_response.response.status == 404) {
        // Webhook not found or deleted
        throw {
          name = "DiscordAPIError"
          value = "Webhook not found. The webhook may have been deleted or the URL is incorrect."
        }
      }
      elseif ($discord_response.response.status == 429) {
        // Rate limited
        throw {
          name = "DiscordAPIError"
          value = "Rate limited by Discord. Please wait before sending more messages."
        }
      }
      else {
        // Other errors
        throw {
          name = "DiscordAPIError"
          value = "Discord API error (HTTP " ~ ($discord_response.response.status|to_text) ~ "): " ~ ($discord_response.response.result.message ?? "Unknown error")
        }
      }
    }
  }
  
  response = $result
}
