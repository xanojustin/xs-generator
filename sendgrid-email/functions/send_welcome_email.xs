function "send_welcome_email" {
  description = "Send a welcome email via SendGrid API"
  input {
    email to_email
    text to_name
    text subject
    text message
  }
  stack {
    // Validate required environment variables
    precondition ($env.sendgrid_api_key != null && $env.sendgrid_api_key != "") {
      error_type = "standard"
      error = "SENDGRID_API_KEY environment variable is required"
    }

    precondition ($env.sendgrid_from_email != null && $env.sendgrid_from_email != "") {
      error_type = "standard"
      error = "SENDGRID_FROM_EMAIL environment variable is required"
    }

    // Build the SendGrid API payload
    var $payload {
      value = {
        personalizations: [
          {
            to: [
              { email: $input.to_email, name: $input.to_name }
            ]
          }
        ],
        from: {
          email: $env.sendgrid_from_email,
          name: $env.sendgrid_from_name
        },
        subject: $input.subject,
        content: [
          {
            type: "text/plain",
            value: $input.message
          },
          {
            type: "text/html",
            value: "<html><body><h1>" ~ $input.subject ~ "</h1><p>" ~ $input.message ~ "</p></body></html>"
          }
        ]
      }
    }

    // Make the API request to SendGrid
    api.request {
      url = "https://api.sendgrid.com/v3/mail/send"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.sendgrid_api_key
      ]
      params = $payload
      timeout = 30
    } as $api_result

    // Check for successful response
    var $status_code { value = $api_result.response.status }

    conditional {
      if ($status_code >= 200 && $status_code < 300) {
        var $result {
          value = {
            success: true,
            message: "Email sent successfully",
            to: $input.to_email,
            status_code: $status_code
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            message: "Failed to send email",
            to: $input.to_email,
            status_code: $status_code,
            error: $api_result.response.result
          }
        }
      }
    }
  }
  response = $result
}
