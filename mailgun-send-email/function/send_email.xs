function "send_email" {
  input {
    text to
    text subject
    text body
    text? from_name="Xano Notification"
  }

  stack {
    // Get environment variables
    var $api_key { value = $env.MAILGUN_API_KEY }
    var $domain { value = $env.MAILGUN_DOMAIN }
    var $from_email { value = $env.MAILGUN_FROM_EMAIL }

    // Validate required environment variables
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "MAILGUN_API_KEY environment variable is required"
    }

    precondition ($domain != null && $domain != "") {
      error_type = "standard"
      error = "MAILGUN_DOMAIN environment variable is required"
    }

    precondition ($from_email != null && $from_email != "") {
      error_type = "standard"
      error = "MAILGUN_FROM_EMAIL environment variable is required"
    }

    // Build the from field with name and email
    var $from { value = $from_name ~ " <" ~ $from_email ~ ">" }

    // Build the request URL
    var $url { value = "https://api.mailgun.net/v3/" ~ $domain ~ "/messages" }

    // Build the request payload (Mailgun uses form-encoded data)
    var $payload {
      value = {
        from: $from,
        to: $to,
        subject: $subject,
        text: $body
      }
    }

    // Create Basic Auth header (Mailgun uses "api" as username and API key as password)
    var $auth_string { value = "api:" ~ $api_key }
    var $auth_base64 { value = $auth_string|base64_encode }
    var $auth_header { value = "Authorization: Basic " ~ $auth_base64 }

    // Make the API request to Mailgun
    api.request {
      url = $url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/x-www-form-urlencoded",
        $auth_header
      ]
      timeout = 30
    } as $api_result

    // Check response status
    conditional {
      if ($api_result.response.status == 200) {
        // Success - extract message ID
        var $message_id { value = $api_result.response.result.id }
        var $email_response { 
          value = {
            success: true,
            message_id: $message_id,
            message: "Email sent successfully"
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        // Authentication error
        throw {
          name = "AuthenticationError"
          value = "Invalid Mailgun API key"
        }
      }
      elseif ($api_result.response.status == 404) {
        // Domain not found
        throw {
          name = "NotFoundError"
          value = "Mailgun domain not found: " ~ $domain
        }
      }
      else {
        // Other errors
        var $error_message { value = $api_result.response.result|json_encode }
        throw {
          name = "MailgunAPIError"
          value = "Mailgun API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ $error_message
        }
      }
    }
  }

  response = $email_response
}
