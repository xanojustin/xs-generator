function "send_transactional_email" {
  description = "Send a transactional email using the Brevo (Sendinblue) API"
  input {
    email to_email filters=trim|lower { description = "Recipient email address" }
    text to_name?="" filters=trim { description = "Recipient name" }
    text subject filters=trim { description = "Email subject line" }
    text html_content { description = "HTML version of the email content" }
    text text_content { description = "Plain text version of the email content" }
    email sender_email filters=lower { description = "Sender email address (must be verified in Brevo)" }
    text sender_name?="" filters=trim { description = "Sender display name" }
  }
  stack {
    // Validate required environment variable
    precondition ($env.BREVO_API_KEY != null && $env.BREVO_API_KEY != "") {
      error_type = "standard"
      error = "BREVO_API_KEY environment variable is required"
    }

    // Build the email payload
    var $email_payload {
      value = {
        sender: {
          email: $input.sender_email
          name: $input.sender_name
        }
        to: [
          {
            email: $input.to_email
            name: $input.to_name
          }
        ]
        subject: $input.subject
        htmlContent: $input.html_content
        textContent: $input.text_content
      }
    }

    // Send the email via Brevo API
    api.request {
      url = "https://api.brevo.com/v3/smtp/email"
      method = "POST"
      params = $email_payload
      headers = [
        "Content-Type: application/json"
        "api-key: " ~ $env.BREVO_API_KEY
      ]
      timeout = 30
    } as $api_result

    // Check if the request was successful
    conditional {
      if ($api_result.response.status == 201) {
        // Email sent successfully
        var $email_response {
          value = {
            success: true
            message: "Email sent successfully"
            message_id: $api_result.response.result.messageId
            email: $input.to_email
            subject: $input.subject
            sent_at: now
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request - invalid input
        throw {
          name = "InvalidRequest"
          value = "Invalid request: " ~ ($api_result.response.result|json_encode)
        }
      }
      elseif ($api_result.response.status == 401) {
        // Unauthorized - invalid API key
        throw {
          name = "Unauthorized"
          value = "Invalid Brevo API key. Please check your BREVO_API_KEY environment variable."
        }
      }
      elseif ($api_result.response.status == 403) {
        // Forbidden - sender not verified
        throw {
          name = "SenderNotVerified"
          value = "Sender email is not verified in Brevo. Please verify " ~ $input.sender_email ~ " in your Brevo dashboard."
        }
      }
      else {
        // Other errors
        throw {
          name = "APIError"
          value = "Brevo API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $email_response
}
