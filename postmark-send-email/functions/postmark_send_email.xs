function "postmark/send_email" {
  description = "Send a transactional email using the Postmark API"

  input {
    email to {
      description = "Recipient email address"
      sensitive = false
    }

    text subject filters=trim {
      description = "Email subject line"
    }

    text html_body? {
      description = "HTML content of the email"
    }

    text text_body? {
      description = "Plain text content of the email"
    }

    email from? {
      description = "Sender email address"
    }

    text tag? filters=trim {
      description = "Tag for categorizing emails in Postmark"
    }
  }

  stack {
    precondition ($input.html_body != null || $input.text_body != null) {
      error_type = "validation"
      error = "Either html_body or text_body must be provided"
    }

    precondition ($env.postmark_api_key != null) {
      error_type = "configuration"
      error = "Postmark API key not configured in environment variables"
    }

    api.request {
      description = "Send email via Postmark API"
      url = "https://api.postmarkapp.com/email"
      method = "POST"
      headers = [
        "Accept: application/json",
        "Content-Type: application/json",
        "X-Postmark-Server-Token: " ~ $env.postmark_api_key
      ]
      payload = {
        From: $input.from,
        To: $input.to,
        Subject: $input.subject,
        HtmlBody: $input.html_body,
        TextBody: $input.text_body,
        Tag: $input.tag
      }
      timeout = 30
    } as $postmark_response

    conditional {
      description = "Check for API error response"
      if ($postmark_response|get:"ErrorCode":0 != 0) {
        throw {
          name = "PostmarkError"
          value = $postmark_response|get:"Message":"Unknown error"
        }
      }
    }
  }

  response = {
    success: true,
    message_id: $postmark_response|get:"MessageID":null,
    to: $postmark_response|get:"To":null,
    submitted_at: $postmark_response|get:"SubmittedAt":null
  }
}
