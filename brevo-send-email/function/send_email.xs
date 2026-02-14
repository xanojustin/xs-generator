function "send_email" {
  description = "Send transactional email using Brevo API"
  input {
    text to_email filters=trim
    text to_name? filters=trim
    text from_email filters=trim
    text from_name? filters=trim
    text subject filters=trim
    text html_content filters=trim
    text text_content? filters=trim
  }

  stack {
    var $api_key { value = $env.BREVO_API_KEY }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "BREVO_API_KEY environment variable not configured"
    }

    precondition ($input.to_email != null && $input.to_email != "") {
      error_type = "inputerror"
      error = "Recipient email is required"
    }

    var $to_object {
      value = {
        email: $input.to_email
      }
    }

    conditional {
      if ($input.to_name != null && $input.to_name != "") {
        var.update $to_object {
          value = $to_object|set:"name":$input.to_name
        }
      }
    }

    var $sender_object {
      value = {
        email: $input.from_email
      }
    }

    conditional {
      if ($input.from_name != null && $input.from_name != "") {
        var.update $sender_object {
          value = $sender_object|set:"name":$input.from_name
        }
      }
    }

    var $payload {
      value = {
        sender: $sender_object,
        to: [$to_object],
        subject: $input.subject,
        htmlContent: $input.html_content
      }
    }

    conditional {
      if ($input.text_content != null && $input.text_content != "") {
        var.update $payload {
          value = $payload|set:"textContent":$input.text_content
        }
      }
    }

    api.request {
      url = "https://api.brevo.com/v3/smtp/email"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "api-key: " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    var $success { value = false }
    var $message_id { value = null }

    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $message_id { value = $response_body|get:"messageId" }
      }
    }
  }

  response = {
    success: $success,
    message_id: $message_id
  }
}
