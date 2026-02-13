function "send_email" {
  description = "Send an email using the Resend API"
  input {
    email to filters=trim|lower
    text subject filters=trim
    text html
    text? from
    text? reply_to
  }
  stack {
    // Set default from address if not provided
    var $from_address {
      value = ($input.from != null) ? $input.from : "onboarding@resend.dev"
    }

    // Prepare request body
    var $request_body {
      value = {
        from: $from_address,
        to: $input.to,
        subject: $input.subject,
        html: $input.html
      }
    }

    // Add reply_to if provided
    conditional {
      if ($input.reply_to != null) {
        var.update $request_body.reply_to { value = $input.reply_to }
      }
    }

    // Make API request to Resend
    api.request {
      url = "https://api.resend.com/emails"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.RESEND_API_KEY
      ]
      params = $request_body
      timeout = 30
    } as $api_result

    // Check if request was successful
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Failed to send email: " ~ $api_result.response.result|json_encode
    }

    // Extract response data
    var $email_response { value = $api_result.response.result }
  }
  response = {
    success: true,
    message_id: $email_response.id,
    to: $input.to,
    subject: $input.subject
  }
}
