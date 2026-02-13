function "send_email" {
  description = "Send an email using the Resend API"
  input {
    text to
    text subject
    text html
  }
  stack {
    // Get the from email from environment variable or use default
    conditional {
      if ($env.resend_from_email != null) {
        var $from_email {
          value = $env.resend_from_email
        }
      }
      else {
        var $from_email {
          value = "onboarding@resend.dev"
        }
      }
    }

    // Build the request payload for Resend API
    var $payload {
      value = {
        from: $from_email,
        to: $input.to,
        subject: $input.subject,
        html: $input.html
      }
    }

    // Make the API request to Resend
    api.request {
      url = "https://api.resend.com/emails"
      method = "POST"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.resend_api_key
      ]
      params = $payload
      timeout = 30
    } as $api_result

    // Check the HTTP status
    var $http_status {
      value = $api_result.response.status
    }

    conditional {
      if ($http_status == 200 || $http_status == 202) {
        // Email sent successfully
        var $response_data {
          value = $api_result.response.result
        }
        var $status {
          value = "success"
        }
        var $message {
          value = "Email sent successfully. ID: " ~ $response_data.id
        }
      }
      else {
        // Handle error
        var $response_data {
          value = $api_result.response.result
        }
        var $status {
          value = "error"
        }
        var $status_text {
          value = $http_status|to_text
        }
        var $error_message {
          value = ($response_data.message != null) ? $response_data.message : "Unknown error"
        }
        var $message {
          value = "Failed to send email. Status: " ~ $status_text ~ ", Error: " ~ $error_message
        }
      }
    }

    // Build the final result
    var $result {
      value = {
        status: $status,
        message: $message,
        resend_response: $response_data
      }
    }
  }
  response = $result
}