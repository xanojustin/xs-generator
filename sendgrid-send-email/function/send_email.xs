function "send_email" {
  description = "Send an email using the SendGrid API v3"
  input {
    text to
    text subject
    text html
  }
  stack {
    // Get the from email from environment variable or use default
    conditional {
      if ($env.sendgrid_from_email != null) {
        var $from_email {
          value = $env.sendgrid_from_email
        }
      }
      else {
        var $from_email{
          value = "noreply@example.com"
        }
      }
    }

    // Build the personalizations array for SendGrid
    var $to_array{
      value = [{email: $input.to}]
    }

    var $personalizations{
      value = [{to: $to_array}]
    }

    // Build the from object
    var $from_object{
      value = {email: $from_email}
    }

    // Build the content array (SendGrid requires type and value)
    var $content_array{
      value = [{type: "text/html", value: $input.html}]
    }

    // Build the request payload for SendGrid API v3
    var $payload{
      value = {
        personalizations: $personalizations,
        from: $from_object,
        subject: $input.subject,
        content: $content_array
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

    // Check the HTTP status
    var $http_status{
      value = $api_result.response.status
    }

    conditional {
      if ($http_status == 200 || $http_status == 202) {
        // Email sent successfully - SendGrid returns 202 Accepted
        var $status{
          value = "success"
        }
        var $message{
          value = "Email sent successfully via SendGrid"
        }
        var $response_data{
          value = $api_result.response.result
        }
      }
      else {
        // Handle error
        var $response_data{
          value = $api_result.response.result
        }
        var $status{
          value = "error"
        }
        var $status_text{
          value = $http_status|to_text
        }
        var $error_message{
          value = "Failed to send email. Status: " ~ $status_text
        }
        conditional {
          if ($response_data != null && $response_data.errors != null) {
            var $error_details{
              value = $response_data.errors|json_encode
            }
            var.update $error_message{
              value = $error_message ~ ", Errors: " ~ $error_details
            }
          }
        }
      }
    }

    // Build the final result
    var $result{
      value = {
        status: $status,
        message: $message,
        sendgrid_response: $response_data
      }
    }
  }
  response = $result
}
