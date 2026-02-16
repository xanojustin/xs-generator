function "send_email" {
  input {
    text to_email
    text to_name?=""
    text from_email
    text from_name?=""
    text subject
    text body_text
    text body_html?=""
  }
  stack {
    // Step 1: Validate the recipient email format
    function.run "validate_email" {
      input = {
        email: $input.to_email
      }
    } as $validation_result

    precondition ($validation_result.valid == true) {
      error_type = "standard"
      error = "Invalid recipient email format: " ~ $input.to_email
    }

    // Step 2: Build the email payload for SendGrid
    var $personalizations {
      value = [
        {
          to: [
            {
              email: $input.to_email
              name: $input.to_name
            }
          ]
        }
      ]
    }

    var $from_obj {
      value = {
        email: $input.from_email
        name: $input.from_name
      }
    }

    var $content {
      value = [
        {
          type: "text/plain"
          value: $input.body_text
        }
      ]
    }

    // Add HTML content if provided
    conditional {
      if ($input.body_html != "") {
        var.update $content {
          value = $content|append:{
            type: "text/html"
            value: $input.body_html
          }
        }
      }
    }

    var $email_payload {
      value = {
        personalizations: $personalizations
        from: $from_obj
        subject: $input.subject
        content: $content
      }
    }

    // Step 3: Send the email via SendGrid API
    api.request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      params = $email_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.sendgrid_api_key
      ]
      timeout = 30
    } as $sendgrid_response

    // Step 4: Validate the response (SendGrid returns 202 for accepted)
    precondition ($sendgrid_response.response.status == 202) {
      error_type = "standard"
      error = "SendGrid API error: " ~ ($sendgrid_response.response.status|to_text)
    }

    // Step 5: Log the successful send
    debug.log {
      value = "Email sent successfully to: " ~ $input.to_email ~ " with subject: " ~ $input.subject
    }

    // Step 6: Try to save to email log table if it exists
    try_catch {
      try {
        db.add "email_log" {
          data = {
            to_email: $input.to_email
            to_name: $input.to_name
            from_email: $input.from_email
            subject: $input.subject
            status: "sent"
            sent_at: now
          }
        }
      }
      catch {
        debug.log { value = "Note: email_log table not found, skipping database storage" }
      }
    }
  }
  response = {
    success: true
    message: "Email sent successfully"
    to_email: $input.to_email
    subject: $input.subject
    sent_at: now
  }
}
