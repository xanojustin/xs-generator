function "send_email" {
  description = "Send an email using the Resend API"
  input {
    text to filters=trim
    text subject filters=trim
    text body filters=trim
    text from filters=trim
  }
  stack {
    var $payload {
      value = {
        from: $input.from
        to: $input.to
        subject: $input.subject
        html: $input.body
      }
    }

    api.request {
      url = "https://api.resend.com/emails"
      method = "POST"
      params = $payload
      headers = ["Content-Type: application/json", "Authorization: Bearer " ~ $env.RESEND_API_KEY]
      timeout = 30
    } as $api_result

    precondition ($api_result.response.status == 200 || $api_result.response.status == 202) {
      error_type = "standard"
      error = "Resend API request failed: " ~ ($api_result.response.status|to_text)
    }

    var $email_id { value = $api_result.response.result.id }

    db.add email_log {
      data = {
        recipient: $input.to
        subject: $input.subject
        sent_at: now
        status: "sent"
        provider_id: $email_id
      }
    } as $log_entry

    var $result {
      value = {
        success: true
        email_id: $email_id
        recipient: $input.to
        logged_id: $log_entry.id
      }
    }
  }
  response = $result
}
