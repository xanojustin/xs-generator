function "send_email" {
  description = "Send an email using SendGrid API"
  input {
    email to filters=trim|lower
    email from filters=trim|lower
    text subject filters=trim
    text text filters=trim
    text html? filters=trim
  }
  stack {
    precondition (($input.to|is_empty) == false) {
      error_type = "inputerror"
      error = "Recipient email (to) is required"
    }

    precondition (($input.from|is_empty) == false) {
      error_type = "inputerror"
      error = "Sender email (from) is required"
    }

    precondition (($input.subject|is_empty) == false) {
      error_type = "inputerror"
      error = "Subject is required"
    }

    var $personalizations {
      value = [
        {
          to: [{email: $input.to}]
        }
      ]
    }

    var $email_content {
      value = [
        {type: "text/plain", value: $input.text}
      ]
    }

    conditional {
      if ($input.html != null && ($input.html|is_empty) == false) {
        var $html_content {
          value = {type: "text/html", value: $input.html}
        }
        var.update $email_content {
          value = $email_content|push:$html_content
        }
      }
    }

    var $request_body {
      value = {
        personalizations: $personalizations,
        from: {email: $input.from},
        subject: $input.subject,
        content: $email_content
      }
    }

    api.request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      headers = [
        "Authorization: Bearer " ~ $env.sendgrid_api_key,
        "Content-Type: application/json"
      ]
      params = $request_body
    } as $api_result

    var $status_code {
      value = $api_result.response.status
    }

    precondition ($status_code == 202 || $status_code == 200) {
      error_type = "standard"
      error = "SendGrid API error"
    }
  }
  response = {
    success: true,
    message: "Email sent successfully to " ~ $input.to,
    status_code: $status_code
  }
}
