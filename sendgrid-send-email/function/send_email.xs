function "send_email" {
  description = "Send an email using the SendGrid API"
  input {
    text to filters=trim
    text subject filters=trim
    text body filters=trim
    text from filters=trim
  }
  stack {
    var $payload {
      value = {
        personalizations: [
          {
            to: [
              { email: $input.to }
            ]
          }
        ]
        from: { email: $input.from }
        subject: $input.subject
        content: [
          {
            type: "text/html"
            value: $input.body
          }
        ]
      }
    }

    api.request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.SENDGRID_API_KEY
      ]
      timeout = 30
    } as $api_result

    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "SendGrid API request failed: " ~ ($api_result.response.status|to_text)
    }

    db.add email_log {
      data = {
        recipient: $input.to
        subject: $input.subject
        sent_at: now
        status: "sent"
        provider: "sendgrid"
      }
    } as $log_entry

    var $result {
      value = {
        success: true
        recipient: $input.to
        logged_id: $log_entry.id
      }
    }
  }
  response = $result
}
