function "send_telegram_message" {
  description = "Send a message via Telegram Bot API"
  input {
    text chat_id { description = "Telegram chat ID or channel username (e.g., @channelname)" }
    text message { description = "Message text to send (max 4096 characters)" }
    text parse_mode?="HTML" { description = "Parse mode: HTML, Markdown, or MarkdownV2" }
    bool disable_notification?=false { description = "Send message silently" }
  }
  stack {
    // Validate inputs
    precondition (($input.chat_id|trim) != "") {
      error_type = "inputerror"
      error = "chat_id is required"
    }
    
    precondition (($input.message|trim) != "") {
      error_type = "inputerror"
      error = "message is required"
    }

    // Build the request payload
    var $payload {
      value = {
        chat_id: $input.chat_id,
        text: $input.message,
        parse_mode: $input.parse_mode,
        disable_notification: $input.disable_notification
      }
    }

    // Make the API request to Telegram Bot API
    api.request {
      url = "https://api.telegram.org/bot" ~ $env.telegram_bot_token ~ "/sendMessage"
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $api_result

    // Check response status
    conditional {
      if ($api_result.response.status == 200) {
        var $result { value = $api_result.response.result }
        var $api_response { value = { success: false } }
        
        // Check if Telegram API returned ok: true
        conditional {
          if ($result.ok == true) {
            var $message_id { value = $result.result.message_id }
            var.update $api_response {
              value = { 
                success: true, 
                message_id: $message_id,
                chat_id: $result.result.chat.id,
                date: $result.result.date
              } 
            }
          }
          else {
            var $error_desc { value = $result.description }
            conditional {
              if ($error_desc == null) {
                var.update $error_desc { value = "Unknown error" }
              }
            }
            throw {
              name = "TelegramAPIError"
              value = "Telegram API error: " ~ $error_desc
            }
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid bot token. Check your TELEGRAM_BOT_TOKEN environment variable."
        }
      }
      elseif ($api_result.response.status == 400) {
        var $error_msg { value = "Invalid parameters" }
        conditional {
          if ($api_result.response.result.description != null) {
            var.update $error_msg { value = $api_result.response.result.description }
          }
        }
        throw {
          name = "BadRequestError"
          value = "Bad request: " ~ $error_msg
        }
      }
      else {
        throw {
          name = "APIError"
          value = "HTTP " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $api_response
}
