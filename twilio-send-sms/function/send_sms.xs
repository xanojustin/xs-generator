function "send_sms" {
  description = "Send an SMS message using the Twilio API"
  input {
  }
  stack {
    // Get configuration from environment variables with defaults
    var $to_number {
      value = $env.twilio_to_number
    }
    var $from_number {
      value = $env.twilio_from_number
    }

    // Set default message body if not provided
    conditional {
      if ($env.twilio_message_body != null) {
        var $message_body {
          value = $env.twilio_message_body
        }
      }
      else {
        var $message_body {
          value = "Hello from Xano! This is a test SMS sent via Twilio."
        }
      }
    }

    // Build the Twilio API URL with account SID
    var $twilio_url {
      value = "https://api.twilio.com/2010-04-01/Accounts/" ~ $env.twilio_account_sid ~ "/Messages.json"
    }

    // Create Basic Auth header (Base64 of AccountSid:AuthToken)
    var $auth_header {
      value = "Authorization: Basic " ~ ($env.twilio_account_sid ~ ":" ~ $env.twilio_auth_token)|base64_encode
    }

    // Prepare form data for the request
    var $form_data {
      value = {
        To: $to_number,
        From: $from_number,
        Body: $message_body
      }
    }

    // Make the API request to Twilio
    api.request {
      url = $twilio_url
      method = "POST"
      params = $form_data
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        $auth_header
      ]
      timeout = 30
    } as $api_result

    // Check if the request was successful
    var $http_status {
      value = ($api_result.response.status)
    }

    conditional {
      if ($http_status == 201) {
        // SMS sent successfully
        var $response_data {
          value = $api_result.response.result
        }
        var $status {
          value = "success"
        }
        var $message {
          value = "SMS sent successfully. SID: " ~ $response_data.sid
        }
      }
      else {
        // Handle error
        var $response_data {
          value = $api_result.response.result
        }
        var $status {
          value = "error"
        }
        var $status_text {
          value = ($api_result.response.status)|to_text
        }
        var $message {
          value = "Failed to send SMS. Status: " ~ $status_text ~ ", Error: " ~ $response_data.message
        }
      }
    }

    // Build the final result
    var $result {
      value = {
        status: $status,
        message: $message,
        twilio_response: $response_data
      }
    }
  }
  response = $result
}
