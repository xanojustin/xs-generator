function "start_verification" {
  description = "Start a phone verification via Twilio Verify API"
  input {
    text to_phone filters=trim { description = "Phone number to verify (E.164 format, e.g., +1234567890)" }
    text channel?="sms" filters=trim { description = "Verification channel: sms, call, email, or whatsapp (default: sms)" }
    text service_sid filters=trim { description = "Twilio Verify Service SID (e.g., VAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)" }
  }

  stack {
    // Get credentials from environment
    var $account_sid { value = $env.twilio_account_sid }
    var $auth_token { value = $env.twilio_auth_token }

    // Validate credentials are configured
    precondition ($account_sid != null && $account_sid != "") {
      error_type = "standard"
      error = "twilio_account_sid environment variable not configured"
    }

    precondition ($auth_token != null && $auth_token != "") {
      error_type = "standard"
      error = "twilio_auth_token environment variable not configured"
    }

    // Validate inputs
    precondition ($input.to_phone != null && $input.to_phone != "") {
      error_type = "inputerror"
      error = "to_phone is required (E.164 format, e.g., +1234567890)"
    }

    precondition ($input.service_sid != null && $input.service_sid != "") {
      error_type = "inputerror"
      error = "service_sid is required (Twilio Verify Service SID)"
    }

    // Build the Twilio Verify API URL
    var $api_url { value = "https://verify.twilio.com/v2/Services/" ~ $input.service_sid ~ "/Verifications" }

    // Prepare request payload
    var $payload {
      value = {
        To: $input.to_phone,
        Channel: $input.channel
      }
    }

    // Create Basic Auth header
    var $auth_string { value = $account_sid ~ ":" ~ $auth_token }

    // Make the API request to Twilio Verify
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

    // Initialize response variables
    var $success { value = false }
    var $sid { value = null }
    var $status { value = null }
    var $error_message { value = null }
    var $valid { value = false }

    // Parse response based on status
    conditional {
      if ($twilio_response.response.status >= 200 && $twilio_response.response.status < 300) {
        var $response_body { value = $twilio_response.response.result }
        var $success { value = true }
        var $sid { value = $response_body|get:"sid" }
        var $status { value = $response_body|get:"status" }
        var $valid { value = true }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Twilio API error: HTTP " ~ ($twilio_response.response.status|to_text)
        }
        conditional {
          if ($twilio_response.response.result != null) {
            var $error_obj { value = $twilio_response.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = $error_obj|get:"message"
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    sid: $sid,
    status: $status,
    valid: $valid,
    error: $error_message
  }
}