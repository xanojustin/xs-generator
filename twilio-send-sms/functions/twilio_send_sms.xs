function "twilio_send_sms" {
  description = "Send an SMS message using the Twilio API"
  input {
    text to filters=trim
    text from_number filters=trim
    text body filters=trim
    text media_url? filters=trim
  }
  stack {
    precondition (($input.to|is_empty) == false) {
      error_type = "inputerror"
      error = "Recipient phone number (to) is required"
    }

    precondition (($input.from_number|is_empty) == false) {
      error_type = "inputerror"
      error = "Sender phone number (from) is required"
    }

    precondition (($input.body|is_empty) == false) {
      error_type = "inputerror"
      error = "Message body is required"
    }

    var $auth_string {
      value = $env.twilio_account_sid ~ ":" ~ $env.twilio_auth_token
    }

    var $auth_header {
      value = "Basic " ~ ($auth_string|base64_encode)
    }

    var $message_body {
      value = {
        To: $input.to,
        From: $input.from_number,
        Body: $input.body
      }
    }

    conditional {
      if (($input.media_url|is_empty) == false) {
        var $message_body {
          value = $message_body|set:"MediaUrl":$input.media_url
        }
      }
    }

    var $twilio_url {
      value = "https://api.twilio.com/2010-04-01/Accounts/" ~ $env.twilio_account_sid ~ "/Messages.json"
    }

    api.request {
      url = $twilio_url
      method = "POST"
      headers = [
        "Authorization: " ~ $auth_header,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      params = $message_body
    } as $twilio_response

    var $response_status {
      value = $twilio_response.response.status
    }

    precondition ($response_status == 200 || $response_status == 201) {
      error_type = "standard"
      error = "Twilio API error: " ~ ($twilio_response.response.body.message ?? "Unknown error")
    }

    var $message_data {
      value = $twilio_response.response.body
    }
  }
  response = {
    success: true,
    message_sid: $message_data.sid,
    to: $message_data.to,
    from: $message_data.from,
    body: $message_data.body,
    status: $message_data.status,
    direction: $message_data.direction,
    date_created: $message_data.date_created,
    num_segments: $message_data.num_segments,
    price: $message_data.price ?? null
  }
}
