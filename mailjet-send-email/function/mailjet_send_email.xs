function "mailjet_send_email" {
  description = "Send an email using the Mailjet API"
  input {
    text from_email { description = "Sender email address" }
    text from_name { description = "Sender name" }
    text to_email { description = "Recipient email address" }
    text to_name { description = "Recipient name" }
    text subject { description = "Email subject line" }
    text text_content { description = "Plain text email content" }
    text html_content { description = "HTML email content (optional)" }
  }
  stack {
    var $message_payload {
      value = {
        From: {
          Email: $input.from_email,
          Name: $input.from_name
        },
        To: [
          {
            Email: $input.to_email,
            Name: $input.to_name
          }
        ],
        Subject: $input.subject,
        TextPart: $input.text_content
      }
    }

    conditional {
      if ($input.html_content != "") {
        var $message_with_html {
          value = {
            From: $message_payload.value.From,
            To: $message_payload.value.To,
            Subject: $message_payload.value.Subject,
            TextPart: $message_payload.value.TextPart,
            HtmlPart: $input.html_content
          }
        }
        var $message_payload {
          value = $message_with_html
        }
      }
    }

    var $payload {
      value = {
        Messages: [$message_payload.value]
      }
    }

    api.request {
      url = "https://api.mailjet.com/v3.1/send"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($env.mailjet_api_key ~ ":" ~ $env.mailjet_secret_key|base64_encode)
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $send_result { value = $api_result.response.result }
      }
      else {
        throw {
          name = "MailjetAPIError"
          value = "Mailjet API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $send_result
}
