function "send_sms" {
  input {
    text to_number filters=trim
    text from_number filters=trim
    text message_body filters=trim
    text[] media_urls?
  }
  
  stack {
    precondition ($input.to_number != "" && $input.to_number != null) {
      error_type = "inputerror"
      error = "Recipient phone number (to_number) is required"
    }
    
    precondition ($input.from_number != "" && $input.from_number != null) {
      error_type = "inputerror"
      error = "Sender phone number (from_number) is required"
    }
    
    precondition ($input.message_body != "" && $input.message_body != null) {
      error_type = "inputerror"
      error = "Message body is required"
    }
    
    var $account_sid { value = $env.TWILIO_ACCOUNT_SID }
    var $auth_token { value = $env.TWILIO_AUTH_TOKEN }
    
    precondition ($account_sid != "" && $account_sid != null) {
      error_type = "standard"
      error = "TWILIO_ACCOUNT_SID environment variable is not set"
    }
    
    precondition ($auth_token != "" && $auth_token != null) {
      error_type = "standard"
      error = "TWILIO_AUTH_TOKEN environment variable is not set"
    }
    
    var $api_url { 
      value = "https://api.twilio.com/2010-04-01/Accounts/" ~ $account_sid ~ "/Messages.json"
    }
    
    var $payload {
      value = {
        To: $input.to_number,
        From: $input.from_number,
        Body: $input.message_body
      }
    }
    
    conditional {
      if ($input.media_urls != null && ($input.media_urls|count) > 0) {
        foreach ($input.media_urls) {
          each as $media_url {
            var $payload {
              value = $payload|set:"MediaUrl":$media_url
            }
          }
        }
      }
    }
    
    var $credentials { value = $account_sid ~ ":" ~ $auth_token }
    var $encoded_credentials { value = $credentials|base64_encode }
    var $auth_header { value = "Authorization: Basic " ~ $encoded_credentials }
    
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        $auth_header
      ]
      timeout = 30
    } as $twilio_response
    
    conditional {
      if ($twilio_response.response.status >= 200 && $twilio_response.response.status < 300) {
        var $result {
          value = {
            success: true,
            message_sid: $twilio_response.response.result.sid,
            status: $twilio_response.response.result.status,
            to: $twilio_response.response.result.to,
            from: $twilio_response.response.result.from,
            body: $twilio_response.response.result.body,
            date_created: $twilio_response.response.result.date_created,
            uri: $twilio_response.response.result.uri
          }
        }
      }
      else {
        var $error_message { 
          value = $twilio_response.response.result.message ?? "Unknown Twilio API error"
        }
        var $error_code { 
          value = $twilio_response.response.result.code ?? "unknown"
        }
        
        throw {
          name = "TwilioAPIError"
          value = "Twilio API error (" ~ ($twilio_response.response.status|to_text) ~ "): " ~ $error_message ~ " (Code: " ~ $error_code ~ ")"
        }
      }
    }
  }
  
  response = $result
}
