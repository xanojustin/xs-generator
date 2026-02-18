function "send_discord_webhook" {
  description = "Send a message to Discord via webhook"
  input {
    text content filters=trim { description = "The message content to send (max 2000 chars)" }
    text username?="Xano Bot" filters=trim { description = "Username to display as the sender" }
    text avatar_url?="" filters=trim { description = "URL for the avatar image (optional)" }
  }
  stack {
    precondition ($input.content != null && $input.content != "") {
      error_type = "inputerror"
      error = "Content is required"
    }

    var $payload {
      value = {
        content: $input.content,
        username: $input.username
      }
    }

    conditional {
      if ($input.avatar_url != null && $input.avatar_url != "") {
        var.update $payload { value = $payload|set:"avatar_url":$input.avatar_url }
      }
    }

    api.request {
      url = $env.DISCORD_WEBHOOK_URL
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        db.add webhook_log {
          data = {
            content: $input.content,
            username: $input.username,
            avatar_url: $input.avatar_url,
            http_status: $api_result.response.status,
            status: "sent",
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            http_status: $api_result.response.status,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "Discord API error: HTTP " ~ ($api_result.response.status|to_text)
        }

        db.add webhook_log {
          data = {
            content: $input.content,
            username: $input.username,
            avatar_url: $input.avatar_url,
            http_status: $api_result.response.status,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "DiscordError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}