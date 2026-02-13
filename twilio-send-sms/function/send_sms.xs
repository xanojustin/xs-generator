function "send_sms" {
  input {
    text to_phone
    text message
  }
  stack {
    // Validate inputs
    precondition ($input.to_phone != null && $input.to_phone != "") {
      error_type = "inputerror"
      error = "to_phone is required"
    }

    precondition ($input.message != null && $input.message != "") {
      error_type = "inputerror"
      error = "message is required"
    }

    // Build the Twilio API URL
    var $account_sid { value = $env.twilio_account_sid }
    var $api_url { value = "https://api.twilio.com/2010-04-01/Accounts/" ~ $account_sid ~ "/Messages.json" }

    // Prepare request payload (Twilio uses form-encoded data)
    var $payload {
      value = {
        To: $input.to_phone,
        From: $env.twilio_from_number,
        Body: $input.message
      }
    }

    // Create Basic Auth header (AccountSid:AuthToken base64 encoded)
    // Note: XanoScript will handle the base64 encoding
    var $auth_string { value = $account_sid ~ ":" ~ $env.twilio_auth_token }

    // Make the API request to Twilio
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Basic " ~ $auth_string
      ]
      timeout = 30
    } as $twilio_response

    // Check response status
    conditional {
      if ($twilio_response.response.status >= 200 && $twilio_response.response.status < 300) {
        var $result {
          value = {
            success: true,
            sid: $twilio_response.response.result.sid,
            status: $twilio_response.response.result.status,
            to: $twilio_response.response.result.to,
            from: $twilio_response.response.result.from,
            body: $twilio_response.response.result.body
          }
        }
      }
      else {
        var $error_message {
          value = "Twilio API error: " ~ ($twilio_response.response.status|to_text)
        }
        conditional {
          if ($twilio_response.response.result.message != null) {
            var.update $error_message { value = $error_message ~ " - " ~ $twilio_response.response.result.message }
          }
        }
        throw {
          name = "TwilioError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
