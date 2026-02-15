function "send_sms" {
  description = "Send SMS using Vonage (Nexmo) API"
  input {
    text to { description = "Recipient phone number in E.164 format (e.g., +1234567890)" }
    text message { description = "SMS message text" }
  }
  stack {
    // Build the request payload
    var $payload {
      value = {
        api_key: $env.vonage_api_key,
        api_secret: $env.vonage_api_secret,
        from: $env.vonage_from_number,
        to: $input.to,
        text: $input.message
      }
    }

    // Make the API request to Vonage
    api.request {
      url = "https://rest.nexmo.com/sms/json"
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/x-www-form-urlencoded"]
      timeout = 30
    } as $api_result

    // Check for HTTP success
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Vonage API request failed with status: " ~ ($api_result.response.status|to_text)
    }

    // Parse the response
    var $response_data { value = $api_result.response.result }

    // Check Vonage-specific response
    // Vonage returns an array of messages, check the first one
    var $first_message { value = $response_data.messages|first }

    precondition ($first_message.status == "0") {
      error_type = "standard"
      error = "Vonage SMS failed: " ~ $first_message["error-text"]
    }

    // Build success response
    var $result {
      value = {
        success: true,
        message_id: $first_message["message-id"],
        to: $first_message.to,
        remaining_balance: $first_message["remaining-balance"],
        message_price: $first_message["message-price"],
        network: $first_message.network
      }
    }
  }
  response = $result
}
