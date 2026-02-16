function "send_email" {
  description = "Send a transactional email using Resend API"
  input {
    text to_email filters=trim|lower
    text subject filters=trim
    text content { description = "HTML content of the email" }
    text from_name?="Notification Service"
    text from_email?="onboarding@resend.dev"
    text[]? cc_emails
    text[]? bcc_emails
    text? reply_to
  }
  
  stack {
    precondition ($input.to_email != "" && $input.to_email|contains:"@") {
      error_type = "inputerror"
      error = "Valid recipient email is required"
    }
    
    precondition ($input.subject != "") {
      error_type = "inputerror"
      error = "Email subject is required"
    }
    
    var $api_key { value = $env.RESEND_API_KEY }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "RESEND_API_KEY environment variable is required"
    }
    
    var $from_field {
      value = $input.from_name ~ " <" ~ $input.from_email ~ ">"
    }
    
    var $payload {
      value = {
        from: $from_field
        to: [$input.to_email]
        subject: $input.subject
        html: $input.content
      }
    }
    
    conditional {
      if (($input.cc_emails != null) && (($input.cc_emails|count) > 0)) {
        var.update $payload { 
          value = $payload|set:"cc":$input.cc_emails 
        }
      }
    }
    
    conditional {
      if (($input.bcc_emails != null) && (($input.bcc_emails|count) > 0)) {
        var.update $payload { 
          value = $payload|set:"bcc":$input.bcc_emails 
        }
      }
    }
    
    conditional {
      if (($input.reply_to != null) && ($input.reply_to != "")) {
        var.update $payload { 
          value = $payload|set:"reply_to":$input.reply_to 
        }
      }
    }
    
    debug.log { value = "Sending email via Resend to: " ~ $input.to_email }
    
    api.request {
      url = "https://api.resend.com/emails"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 30
    } as $api_result
    
    debug.log { value = "Resend response status: " ~ ($api_result.response.status|to_text) }
    
    conditional {
      if (($api_result.response.status >= 200) && ($api_result.response.status < 300)) {
        var $email_result {
          value = {
            success: true
            to: $input.to_email
            subject: $input.subject
            message_id: $api_result.response.result.id
            from: $from_field
          }
        }
      }
      else {
        throw {
          name = "ResendAPIError"
          value = "Resend API error: " ~ ($api_result.response.status|to_text) ~ " - " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  
  response = $email_result
}
