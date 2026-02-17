function "send_telegram_message" {
  description = "Send a message to a Telegram chat using the Bot API"
  input {
    text chat_id { description = "The Telegram chat ID to send message to" }
    text message { description = "The message text to send" }
  }
  stack {
    // Build the Telegram Bot API URL
    var $telegram_url {
      value = "https://api.telegram.org/bot" ~ $env.telegram_bot_token ~ "/sendMessage"
    }

    // Prepare the request payload
    var $payload {
      value = {
        chat_id: $input.chat_id
        text: $input.message
        parse_mode: "HTML"
      }
    }

    // Make the API request to Telegram
    api.request {
      url = $telegram_url
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $api_result

    // Check if the request was successful
    var $is_success {
      value = $api_result.response.status == 200
    }

    // Build the response
    var $result {
      value = {
        success: $is_success
        status_code: $api_result.response.status
        response: $api_result.response.result
      }
    }
  }
  response = $result
}
