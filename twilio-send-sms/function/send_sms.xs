function "send_sms" {
  description = "Send an SMS message using the Twilio API"
  input {
    text to_number filters=trim
    text message filters=trim
  }
  stack {
    // Validate inputs
    precondition ($input.to_number != null && $input.to_number != "") {
      error_type = "inputerror"
      error = "Recipient phone number (to_number) is required"
    }
    
    precondition ($input.message != null && $input.message != "") {
      error_type = "inputerror"
      error = "Message content is required"
    }
    
    // Validate phone number format (basic E.164 check)
    precondition ($input.to_number|starts_with:"+") {
      error_type = "inputerror"
      error = "Phone number must be in E.164 format (e.g., +1234567890)"
    }
    
    // Get environment variables
    var $account_sid { value = $env.twilio_account_sid }
    var $auth_token { value = $env.twilio_auth_token }
    var $from_number { value = $env.twilio_phone_number }
    
    // Validate environment variables
    precondition ($account_sid != null && $account_sid != "") {
      error_type = "standard"
      error = "Twilio Account SID is not configured. Set twilio_account_sid environment variable."
    }
    
    precondition ($auth_token != null && $auth_token != "") {
      error_type = "standard"
      error = "Twilio Auth Token is not configured. Set twilio_auth_token environment variable."
    }
    
    precondition ($from_number != null && $from_number != "") {
      error_type = "standard"
      error = "Twilio phone number is not configured. Set twilio_phone_number environment variable."
    }
    
    // Build Twilio API URL
    var $api_url { value = "https://api.twilio.com/2010-04-01/Accounts/" ~ $account_sid ~ "/Messages.json" }
    
    // Build Basic Auth header (Base64 of sid:token)
    var $auth_string { value = $account_sid ~ ":" ~ $auth_token }
    var $auth_b64 { value = $auth_string|base64_encode }
    var $auth_header { value = "Basic " ~ $auth_b64 }
    
    // Build request payload (Twilio uses form-encoded data)
    var $payload { 
      value = {
        To: $input.to_number,
        From: $from_number,
        Body: $input.message
      }
    }
    
    // Make the API request to Twilio
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: " ~ $auth_header
      ]
    } as $twilio_response
    
    // Check response status
    conditional {
      if ($twilio_response.response.status == 201) {
        // Success - message sent
        var $message_sid { value = $twilio_response.response.result.sid }
        var $status { value = $twilio_response.response.result.status }
        var $result { 
          value = {
            success: true,
            message_sid: $message_sid,
            status: $status,
            to: $input.to_number,
            from: $from_number,
            message: "SMS sent successfully"
          }
        }
      }
      elseif ($twilio_response.response.status == 400) {
        // Bad request - likely invalid phone number
        throw {
          name = "TwilioAPIError"
          value = "Invalid request: " ~ ($twilio_response.response.result.message ?? "Unknown error")
        }
      }
      elseif ($twilio_response.response.status == 401) {
        // Authentication error
        throw {
          name = "TwilioAuthError"
          value = "Authentication failed. Check your Twilio credentials."
        }
      }
      elseif ($twilio_response.response.status == 404) {
        // Resource not found
        throw {
          name = "TwilioAPIError"
          value = "Twilio API endpoint not found. Check your Account SID."
        }
      }
      else {
        // Other errors
        var $error_message { 
          value = $twilio_response.response.result.message ?? ("HTTP " ~ ($twilio_response.response.status|to_text))
        }
        throw {
          name = "TwilioAPIError"
          value = "Twilio API error: " ~ $error_message
        }
      }
    }
  }
  response = $result
}
