function "send_email" {
  description = "Send an email using Mailgun API"
  input {
    text to filters=trim { description = "Recipient email address" }
    text from filters=trim { description = "Sender email address (must be verified in Mailgun)" }
    text subject filters=trim { description = "Email subject line" }
    text text_body? filters=trim { description = "Plain text email body" }
    text html_body? filters=trim { description = "HTML email body (optional, will use text_body if not provided)" }
    text mailgun_domain?="" filters=trim { description = "Mailgun domain (uses env var if not provided)" }
  }
  stack {
    // Use provided domain or fall back to environment variable
    var $domain {
      value = $input.mailgun_domain
    }
    
    conditional {
      if ($domain == "") {
        var.update $domain { value = $env.MAILGUN_DOMAIN }
      }
    }
    
    // Validate required inputs
    precondition ($domain != "") {
      error_type = "inputerror"
      error = "Mailgun domain is required. Set MAILGUN_DOMAIN environment variable or pass mailgun_domain parameter."
    }
    
    // Build the request payload
    var $payload {
      value = {
        from: $input.from,
        to: $input.to,
        subject: $input.subject
      }
    }
    
    // Add text body if provided
    conditional {
      if ($input.text_body != null) {
        conditional {
          if ($input.text_body != "") {
            var.update $payload.text { value = $input.text_body }
          }
        }
      }
    }
    
    // Add HTML body if provided
    conditional {
      if ($input.html_body != null) {
        conditional {
          if ($input.html_body != "") {
            var.update $payload.html { value = $input.html_body }
          }
        }
      }
    }
    
    // Check that at least one body exists using simpler validation
    // We'll check the payload object to see if text or html was added
    var $body_count {
      value = $payload|count
    }
    
    // Payload starts with 3 fields (from, to, subject)
    // If body_count is still 3, no body was added
    precondition ($body_count > 3) {
      error_type = "inputerror"
      error = "Either text_body or html_body must be provided"
    }
    
    // Build the API URL
    var $api_url {
      value = "https://api.mailgun.net/v3/" ~ $domain ~ "/messages"
    }
    
    // Make the API request to Mailgun
    // Note: Mailgun uses Basic Auth with "api" as username and API key as password
    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Basic " ~ ("api:" ~ $env.MAILGUN_API_KEY)|base64_encode,
        "Content-Type: application/x-www-form-urlencoded"
      ]
      timeout = 30
    } as $api_result
    
    // Check if the request was successful
    conditional {
      if ($api_result.response.status == 200) {
        var $result {
          value = {
            success: true,
            message_id: $api_result.response.result.id,
            message: "Email sent successfully"
          }
        }
      }
      elseif ($api_result.response.status == 401) {
        var $result {
          value = {
            success: false,
            error: "Authentication failed. Check your MAILGUN_API_KEY environment variable.",
            status: $api_result.response.status
          }
        }
      }
      elseif ($api_result.response.status == 403) {
        var $result {
          value = {
            success: false,
            error: "Forbidden. The from address may not be verified or you lack permissions.",
            status: $api_result.response.status
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        var $result {
          value = {
            success: false,
            error: "Bad request: " ~ ($api_result.response.result|json_encode),
            status: $api_result.response.status
          }
        }
      }
      else {
        var $result {
          value = {
            success: false,
            error: "Mailgun API returned status " ~ ($api_result.response.status|to_text),
            details: $api_result.response.result
          }
        }
      }
    }
  }
  response = $result
}
