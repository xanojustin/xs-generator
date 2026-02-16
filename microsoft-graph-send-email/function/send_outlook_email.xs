function "send_outlook_email" {
  input {
    text to_address
    text subject
    text body
    text body_content_type="HTML"
  }
  stack {
    // Validate required inputs
    precondition ($input.to_address != null && $input.to_address != "") {
      error_type = "inputerror"
      error = "Recipient email address is required"
    }

    precondition ($input.to_address|contains:"@") {
      error_type = "inputerror"
      error = "Invalid recipient email format"
    }

    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Email subject is required"
    }

    precondition ($input.body != null && $input.body != "") {
      error_type = "inputerror"
      error = "Email body is required"
    }

    // Get access token from Microsoft Graph
    var $token_url {
      value = "https://login.microsoftonline.com/" ~ $env.MS_GRAPH_TENANT_ID ~ "/oauth2/v2.0/token"
    }

    var $token_payload {
      value = {
        client_id: $env.MS_GRAPH_CLIENT_ID,
        client_secret: $env.MS_GRAPH_CLIENT_SECRET,
        scope: "https://graph.microsoft.com/.default",
        grant_type: "client_credentials"
      }
    }

    api.request {
      url = $token_url
      method = "POST"
      params = $token_payload
      headers = ["Content-Type: application/x-www-form-urlencoded"]
      timeout = 30
    } as $token_response

    precondition ($token_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to obtain Microsoft Graph access token"
    }

    var $access_token {
      value = $token_response.response.result.access_token
    }

    // Build the email message
    var $message_body {
      value = $input.body
    }

    conditional {
      if ($input.body_content_type == "Text") {
        var $email_payload {
          value = {
            message: {
              subject: $input.subject,
              body: {
                contentType: "Text",
                content: $message_body
              },
              toRecipients: [
                {
                  emailAddress: {
                    address: $input.to_address
                  }
                }
              ]
            }
          }
        }
      }
      else {
        var $email_payload {
          value = {
            message: {
              subject: $input.subject,
              body: {
                contentType: "HTML",
                content: $message_body
              },
              toRecipients: [
                {
                  emailAddress: {
                    address: $input.to_address
                  }
                }
              ]
            }
          }
        }
      }
    }

    // Send email via Microsoft Graph API
    var $send_email_url {
      value = "https://graph.microsoft.com/v1.0/users/" ~ $env.MS_GRAPH_FROM_EMAIL ~ "/sendMail"
    }

    api.request {
      url = $send_email_url
      method = "POST"
      params = $email_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
      timeout = 30
    } as $email_response

    precondition ($email_response.response.status == 202) {
      error_type = "standard"
      error = "Failed to send email via Microsoft Graph API"
    }

    var $result {
      value = {
        success: true,
        message: "Email sent successfully via Microsoft Graph",
        to: $input.to_address,
        subject: $input.subject,
        sent_at: now
      }
    }
  }
  response = $result
}