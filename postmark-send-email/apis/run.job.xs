query "/run/job" verb=POST {
  description = "Xano Run Job endpoint for Postmark email integration"

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

    text tag? filters=trim {
      description = "Tag for categorizing the email in Postmark"
    }
  }

  stack {
    precondition ($input.to != null) {
      error_type = "validation"
      error = "Recipient email (to) is required"
    }

    precondition ($input.subject != null) {
      error_type = "validation"
      error = "Subject is required"
    }

    precondition ($input.html_body != null || $input.text_body != null) {
      error_type = "validation"
      error = "Either html_body or text_body must be provided"
    }

    function.run "postmark/send_email" {
      description = "Send email via Postmark API"
      input = {
        to: $input.to,
        subject: $input.subject,
        html_body: $input.html_body,
        text_body: $input.text_body,
        tag: $input.tag
      }
    } as $send_result
  }

  response = {
    success: true,
    message: "Email sent successfully",
    message_id: $send_result|get:"MessageID":null,
    recipient: $send_result|get:"To":null,
    submitted_at: $send_result|get:"SubmittedAt":null
  }
}
