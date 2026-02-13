function "mailgun_send_email" {
  description = "Send an email using Mailgun API"
  input {
    email to filters=trim|lower
    text from filters=trim|lower
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

    var $body {
      value = {
        from: $input.from,
        to: $input.to,
        subject: $input.subject,
        text: ($input.text|is_empty) == false ? $input.text : "",
        html: ($input.html|is_empty) == false ? $input.html : ""
      }
    }

    api.request {
      url = "https://api.mailgun.net/v3/" ~ $env.mailgun_domain ~ "/messages"
      method = "POST"
      headers = [
        "Authorization: Basic " ~ ("api:" ~ $env.mailgun_api_key)|base64_encode
      ]
      params = $body
    } as $api_result

    var $status {
      value = $api_result.response.status
    }

    precondition ($status == 200) {
      error_type = "standard"
      error = "Failed to send email: " ~ $api_result.response.body|json_encode
    }

    var $response_body {
      value = $api_result.response.body
    }
  }
  response = {
    success: true,
    message_id: $response_body.id,
    to: $input.to,
    from: $input.from,
    subject: $input.subject
  }
}