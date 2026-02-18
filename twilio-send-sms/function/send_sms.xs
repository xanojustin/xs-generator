function "send_sms" {
  description = "Send an SMS using Twilio API"
  input {
    text to_number filters=trim { description = "Recipient phone number in E.164 format (e.g., +1234567890)" }
    text message_body filters=trim { description = "Message body text" }
    text from_number?="" filters=trim { description = "Optional: Override sender phone number (defaults to TWILIO_PHONE_NUMBER env var)" }
  }
  stack {
    var $from {
      value = (($input.from_number|strlen) > 0) ? $input.from_number : $env.TWILIO_PHONE_NUMBER
    }

    var $payload {
      value = {
        To: $input.to_number,
        From: $from,
        Body: $input.message_body
      }
    }

    var $my_auth {
      value = $env.TWILIO_ACCOUNT_SID ~ ":" ~ $env.TWILIO_AUTH_TOKEN
    }

    var $auth_header {
      value = "Basic " ~ ($my_auth|base64_encode)
    }

    api.request {
      url = "https://api.twilio.com/2010-04-01/Accounts/" ~ $env.TWILIO_ACCOUNT_SID ~ "/Messages.json"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: " ~ $auth_header
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $message { value = $api_result.response.result }

        db.add sms_log {
          data = {
            to_number: $input.to_number,
            from_number: $from,
            message_body: $input.message_body,
            twilio_sid: $message.sid,
            status: $message.status,
            created_at: now
          }
        } as $log_entry

        var $result {
          value = {
            success: true,
            message_sid: $message.sid,
            status: $message.status,
            to: $input.to_number,
            from: $from,
            log_id: $log_entry.id
          }
        }
      }
      else {
        var $error_message {
          value = "Twilio API error: " ~ ($api_result.response.result.message|to_text)
        }

        db.add sms_log {
          data = {
            to_number: $input.to_number,
            from_number: $from,
            message_body: $input.message_body,
            status: "failed",
            error_message: $error_message,
            created_at: now
          }
        } as $log_entry

        throw {
          name = "TwilioError"
          value = $error_message
        }
      }
    }
  }
  response = $result
}
