function "send_email" {
  description = "Send an email using the Mailgun API"
  input {
    text to filters=trim
    text subject filters=trim
    text body filters=trim
    text from filters=trim
  }
  stack {
    var $domain {
      value = $input.from|split:"@"|last
    }

    var $payload {
      value = {
        from: $input.from
        to: $input.to
        subject: $input.subject
        html: $input.body
      }
    }

    api.request {
      url = "https://api.mailgun.net/v3/" ~ $domain ~ "/messages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        "Authorization: Basic " ~ ("api:" ~ $env.MAILGUN_API_KEY)|base64_encode
      ]
      timeout = 30
    } as $api_result

    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "Mailgun API request failed: " ~ ($api_result.response.status|to_text)
    }

    var $message_id { value = $api_result.response.result.id }

    db.add email_log {
      data = {
        recipient: $input.to
        subject: $input.subject
        sent_at: now
        status: "sent"
        provider_id: $message_id
      }
    } as $log_entry

    var $result {
      value = {
        success: true
        message_id: $message_id
        recipient: $input.to
        logged_id: $log_entry.id
      }
    }
  }
  response = $result
}
