function "send_email" {
  input {
    text to
    text subject
    text body
  }
  stack {
    // Validate required inputs
    precondition ($input.to != null && $input.to != "") {
      error_type = "inputerror"
      error = "Recipient email (to) is required"
    }

    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Subject is required"
    }

    precondition ($input.body != null && $input.body != "") {
      error_type = "inputerror"
      error = "Email body is required"
    }

    // Get environment variables
    var $api_key {
      value = $env.postmark_api_key
    }

    var $from_email {
      value = $env.postmark_from_email
    }

    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "POSTMARK_API_KEY environment variable is not set"
    }

    precondition ($from_email != null && $from_email != "") {
      error_type = "standard"
      error = "POSTMARK_FROM_EMAIL environment variable is not set"
    }

    // Build the payload for Postmark API
    var $payload {
      value = {
        From: $from_email
        To: $input.to
        Subject: $input.subject
        TextBody: $input.body
        MessageStream: "outbound"
      }
    }

    // Make the API request to Postmark
    api.request {
      url = "https://api.postmarkapp.com/email"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
        "Accept: application/json"
        "X-Postmark-Server-Token: " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    conditional {
      if ($api_result.response.status == 200) {
        var $response_data {
          value = $api_result.response.result
        }

        var $message_id {
          value = $response_data|get:"MessageID":""
        }

        debug.log {
          value = "Email sent successfully. Message ID: " ~ $message_id
        }
      }
      else {
        var $error_message {
          value = "Postmark API error: HTTP " ~ ($api_result.response.status|to_text)
        }

        conditional {
          if ($api_result.response.result != null) {
            var $api_error {
              value = $api_result.response.result|get:"Message":""
            }

            conditional {
              if ($api_error != "") {
                var.update $error_message {
                  value = $error_message ~ " - " ~ $api_error
                }
              }
            }
          }
        }

        throw {
          name = "PostmarkAPIError"
          value = $error_message
        }
      }
    }
  }
  response = {
    success: true
    message: "Email sent successfully via Postmark"
    recipient: $input.to
    subject: $input.subject
  }
}
