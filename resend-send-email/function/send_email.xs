function "send_email" {
  description = "Send an email using the Resend API"
  input {
    email to filters=trim
    text subject filters=trim
    text html
    text? text_body
    email? from
    text? reply_to
  }
  stack {
    // Validate required environment variable
    precondition ($env.resend_api_key != null && $env.resend_api_key != "") {
      error_type = "standard"
      error = "RESEND_API_KEY environment variable is required"
    }

    // Set default sender if not provided
    var $sender {
      value = $input.from ?? "onboarding@resend.dev"
    }

    // Build request payload
    var $payload {
      value = {
        from: $sender,
        to: $input.to,
        subject: $input.subject,
        html: $input.html
      }
    }

    // Add text body if provided
    conditional {
      if ($input.text_body != null && $input.text_body != "") {
        var.update $payload {
          value = $payload|set:"text":$input.text_body
        }
      }
    }

    // Add reply_to if provided
    conditional {
      if ($input.reply_to != null && $input.reply_to != "") {
        var.update $payload {
          value = $payload|set:"reply_to":$input.reply_to
        }
      }
    }

    // Send request to Resend API
    api.request {
      url = "https://api.resend.com/emails"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.resend_api_key
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $result {
          value = {
            success: true,
            message_id: $api_result.response.result.id,
            to: $input.to,
            status: "sent"
          }
        }
      }
      else {
        var $error_message {
          value = ($api_result.response.result.message|first_notnull:"Unknown error")
        }
        var $result {
          value = {
            success: false,
            error: $error_message,
            status_code: $api_result.response.status
          }
        }
      }
    }
  }
  response = $result
}
