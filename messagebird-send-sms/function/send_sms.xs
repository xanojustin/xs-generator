function "send_sms" {
  input {
    text recipient
    text message_body
    text originator?
  }
  stack {
    // Validate required inputs
    precondition ($input.recipient != null && $input.recipient != "") {
      error_type = "inputerror"
      error = "Recipient phone number is required"
    }
    
    precondition ($input.message_body != null && $input.message_body != "") {
      error_type = "inputerror"
      error = "Message body is required"
    }
    
    // Use provided originator or default to "Bird"
    var $from {
      value = $input.originator ?? "Bird"
    }
    
    // Build the request payload
    var $payload {
      value = {
        recipients: [$input.recipient],
        body: $input.message_body,
        originator: $from
      }
    }
    
    // Send SMS via MessageBird API
    api.request {
      url = "https://api.bird.com/workspaces/" ~ $env.MESSAGEBIRD_WORKSPACE_ID ~ "/channels/" ~ $env.MESSAGEBIRD_CHANNEL_ID ~ "/messages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.MESSAGEBIRD_API_KEY
      ]
      timeout = 30
    } as $api_result
    
    // Check for successful response
    var $sms_result { value = {} }
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var.update $sms_result {
          value = {
            success: true,
            message_id: $api_result.response.result.id,
            status: $api_result.response.result.status,
            recipient: $input.recipient,
            body: $input.message_body
          }
        }
      }
      else {
        var $error_message {
          value = "MessageBird API error: " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result.errors != null) {
            var $error_details {
              value = $api_result.response.result.errors|map:$$.message
            }
            var.update $error_message {
              value = $error_message ~ " - " ~ ($error_details|join:", ")
            }
          }
        }
        throw {
          name = "APIError"
          value = $error_message
        }
      }
    }
  }
  response = $sms_result
}
