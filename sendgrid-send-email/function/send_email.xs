function "send_email" {
  description = "Send a transactional email via SendGrid API"
  input {
    text to_email filters=trim { description = "Recipient email address" }
    text to_name? filters=trim { description = "Recipient name (optional)" }
    text from_email filters=trim { description = "Sender email address" }
    text from_name? filters=trim { description = "Sender name (optional)" }
    text subject filters=trim { description = "Email subject line" }
    text body_text? { description = "Plain text email body (optional if body_html provided)" }
    text body_html? { description = "HTML email body (optional if body_text provided)" }
  }

  stack {
    // Validate that at least one body is provided
    precondition ($input.body_text != null || $input.body_html != null) {
      error_type = "inputerror"
      error = "Either body_text or body_html must be provided"
    }

    // Get API key from environment
    var $api_key { value = $env.SENDGRID_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "SENDGRID_API_KEY environment variable not configured"
    }

    // Build personalizations (recipient)
    var $personalization {
      value = {
        to: [{ email: $input.to_email }]
      }
    }

    // Add recipient name if provided
    conditional {
      if ($input.to_name != null && $input.to_name != "") {
        var.update $personalization {
          value = $personalization|set:"to":[{
            email: $input.to_email,
            name: $input.to_name
          }]
        }
      }
    }

    // Build from field
    var $from {
      value = { email: $input.from_email }
    }

    conditional {
      if ($input.from_name != null && $input.from_name != "") {
        var.update $from {
          value = $from|set:"name":$input.from_name
        }
      }
    }

    // Build content array
    var $content { value = [] }

    conditional {
      if ($input.body_text != null && $input.body_text != "") {
        var.update $content {
          value = $content|push:{
            type: "text/plain",
            value: $input.body_text
          }
        }
      }
    }

    conditional {
      if ($input.body_html != null && $input.body_html != "") {
        var.update $content {
          value = $content|push:{
            type: "text/html",
            value: $input.body_html
          }
        }
      }
    }

    // Build the request payload
    var $payload {
      value = {
        personalizations: [$personalization],
        from: $from,
        subject: $input.subject,
        content: $content
      }
    }

    // Send the request to SendGrid
    api.request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result

    // Check response status
    var $success { value = false }
    var $error_message { value = null }

    conditional {
      if ($api_result.response.status == 202) {
        var $success { value = true }
      }
      elseif ($api_result.response.status == 200) {
        var $success { value = true }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "SendGrid API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.body != null) {
            var $error_message {
              value = $error_message ~ " - " ~ ($api_result.response.body|json_encode)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    status_code: $api_result.response.status,
    error: $error_message
  }
}