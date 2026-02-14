function "send_email" {
  description = "Send a transactional email using the Postmark API"
  input {
    email to filters=trim
    text subject filters=trim
    text html_body
    text? text_body
    email? from
    text? tag
    text? reply_to
  }
  stack {
    // Validate required environment variable
    precondition ($env.postmark_server_token != null && $env.postmark_server_token != "") {
      error_type = "standard"
      error = "POSTMARK_SERVER_TOKEN environment variable is required"
    }

    // Validate required inputs
    precondition ($input.to != null && $input.to != "") {
      error_type = "inputerror"
      error = "Recipient email (to) is required"
    }

    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Subject is required"
    }

    // Set default sender if not provided (Postmark requires a verified sender)
    var $sender {
      value = $input.from ?? "sender@example.com"
    }

    // Build request payload
    var $payload {
      value = {
        From: $sender,
        To: $input.to,
        Subject: $input.subject,
        HtmlBody: $input.html_body
      }
    }

    // Add text body if provided (for email clients that don't support HTML)
    conditional {
      if ($input.text_body != null && $input.text_body != "") {
        var.update $payload {
          value = $payload|set:"TextBody":$input.text_body
        }
      }
    }

    // Add tag for tracking/category if provided
    conditional {
      if ($input.tag != null && $input.tag != "") {
        var.update $payload {
          value = $payload|set:"Tag":$input.tag
        }
      }
    }

    // Add reply-to if provided
    conditional {
      if ($input.reply_to != null && $input.reply_to != "") {
        var.update $payload {
          value = $payload|set:"ReplyTo":$input.reply_to
        }
      }
    }

    // Send request to Postmark API
    api.request {
      url = "https://api.postmarkapp.com/email"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Accept: application/json",
        "X-Postmark-Server-Token: " ~ $env.postmark_server_token
      ]
      timeout = 30
    } as $api_result

    // Process response
    conditional {
      if ($api_result.response.status == 200) {
        // Successful send
        var $result {
          value = {
            success: true,
            message_id: $api_result.response.result.MessageID,
            to: $api_result.response.result.To,
            submitted_at: $api_result.response.result.SubmittedAt,
            status: $api_result.response.result.Message
          }
        }
      }
      else {
        // API error - Postmark returns 422 for validation errors with detailed message
        var $error_code {
          value = $api_result.response.result.ErrorCode ?? 0
        }
        var $error_message {
          value = $api_result.response.result.Message ?? "Unknown error occurred"
        }
        var $result {
          value = {
            success: false,
            error_code: $error_code,
            error: $error_message,
            status_code: $api_result.response.status
          }
        }
      }
    }
  }
  response = $result
}
