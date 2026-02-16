function "send_email" {
  description = "Send a transactional email using SendGrid API"
  input {
    text to_email filters=trim|lower
    text subject filters=trim
    text content { description = "HTML content of the email" }
    text from_name?="Notification Service"
    text from_email?="noreply@example.com"
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
    
    var $api_key { value = $env.SENDGRID_API_KEY }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "SENDGRID_API_KEY environment variable is required"
    }
    
    var $payload {
      value = {
        personalizations: [
          {
            to: [
              { email: $input.to_email }
            ]
          }
        ],
        from: {
          email: $input.from_email,
          name: $input.from_name
        },
        subject: $input.subject,
        content: [
          {
            type: "text/html",
            value: $input.content
          }
        ]
      }
    }
    
    debug.log { value = "Sending email to: " ~ $input.to_email }
    
    api.request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result
    
    debug.log { value = "SendGrid response status: " ~ ($api_result.response.status|to_text) }
    
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "SendGrid API error: " ~ ($api_result.response.status|to_text)
    }
    
    var $email_result {
      value = {
        success: true,
        to: $input.to_email,
        subject: $input.subject,
        message_id: $api_result.response.headers|get:"x-message-id":"unknown"
      }
    }
  }
  
  response = $email_result
}
