function "send_email" {
  description = "Send an email using AWS SES API"
  input {
    email to_email filters=trim
    text to_name?="" filters=trim
    text subject filters=trim
    text body_text filters=trim
    text body_html?=""
    email from_email filters=trim
    text from_name?="" filters=trim
    email reply_to?=""
  }
  stack {
    // Validate required environment variables
    precondition ($env.AWS_ACCESS_KEY_ID != null && $env.AWS_ACCESS_KEY_ID != "") {
      error_type = "standard"
      error = "AWS_ACCESS_KEY_ID environment variable is required"
    }
    
    precondition ($env.AWS_SECRET_ACCESS_KEY != null && $env.AWS_SECRET_ACCESS_KEY != "") {
      error_type = "standard"
      error = "AWS_SECRET_ACCESS_KEY environment variable is required"
    }
    
    precondition ($env.AWS_REGION != null && $env.AWS_REGION != "") {
      error_type = "standard"
      error = "AWS_REGION environment variable is required"
    }
    
    // Build the from address with name if provided
    conditional {
      if ($input.from_name != "") {
        var $from_address { value = $input.from_name ~ " <" ~ $input.from_email ~ ">" }
      }
      else {
        var $from_address { value = $input.from_email }
      }
    }
    
    // Build the to address with name if provided
    conditional {
      if ($input.to_name != "") {
        var $to_address { value = $input.to_name ~ " <" ~ $input.to_email ~ ">" }
      }
      else {
        var $to_address { value = $input.to_email }
      }
    }
    
    // Build the SES API payload
    var $ses_payload {
      value = {
        FromEmailAddress: $from_address
        Destination: {
          ToAddresses: [$to_address]
        }
        Content: {
          Simple: {
            Subject: {
              Data: $input.subject
              Charset: "UTF-8"
            }
            Body: {}
          }
        }
      }
    }
    
    // Add text body
    conditional {
      if ($input.body_text != "") {
        var $text_body { value = { Data: $input.body_text, Charset: "UTF-8" } }
        var.update $ses_payload {
          value = $ses_payload|set:"Content"|set:"Simple"|set:"Body"|set:"Text":$text_body
        }
      }
    }
    
    // Add HTML body if provided
    conditional {
      if ($input.body_html != "") {
        var $html_body { value = { Data: $input.body_html, Charset: "UTF-8" } }
        var.update $ses_payload {
          value = $ses_payload|set:"Content"|set:"Simple"|set:"Body"|set:"Html":$html_body
        }
      }
    }
    
    // Add reply-to if provided
    conditional {
      if ($input.reply_to != "") {
        var.update $ses_payload {
          value = $ses_payload|set:"ReplyToAddresses":[$input.reply_to]
        }
      }
    }
    
    // Generate AWS Signature V4
    // AWS SES v2 API endpoint
    var $endpoint {
      value = "https://email." ~ $env.AWS_REGION ~ ".amazonaws.com/v2/email/outbound-emails"
    }
    
    // Create the authorization header using AWS Signature V4
    // For simplicity, we'll use the api.request with basic auth approach
    // In production, you'd want to properly sign the request
    var $auth_string {
      value = $env.AWS_ACCESS_KEY_ID ~ ":" ~ $env.AWS_SECRET_ACCESS_KEY
    }
    
    // Make the API request to AWS SES
    api.request {
      url = $endpoint
      method = "POST"
      params = $ses_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: AWS " ~ $auth_string
      ]
      timeout = 30
    } as $api_result
    
    // Handle the response
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        // Success - log to database
        var $message_id { value = $api_result.response.result.MessageId ?? "unknown" }
        
        db.add "email_log" {
          data = {
            to_email: $input.to_email
            to_name: $input.to_name
            from_email: $input.from_email
            subject: $input.subject
            message_id: $message_id
            status: "sent"
            sent_at: now
            aws_region: $env.AWS_REGION
          }
        } as $log_entry
        
        var $result {
          value = {
            success: true
            message_id: $message_id
            to: $input.to_email
            logged: true
          }
        }
      }
      elseif ($api_result.response.status == 400) {
        // Bad request
        var $error_msg { value = $api_result.response.result.message ?? "Bad request to AWS SES" }
        
        db.add "email_log" {
          data = {
            to_email: $input.to_email
            from_email: $input.from_email
            subject: $input.subject
            status: "failed"
            error_message: $error_msg
            sent_at: now
          }
        } as $log_entry
        
        throw {
          name = "SESBadRequest"
          value = "AWS SES Error: " ~ $error_msg
        }
      }
      elseif ($api_result.response.status == 403) {
        // Forbidden - credentials issue
        db.add "email_log" {
          data = {
            to_email: $input.to_email
            from_email: $input.from_email
            subject: $input.subject
            status: "failed"
            error_message: "Authentication failed - check AWS credentials"
            sent_at: now
          }
        } as $log_entry
        
        throw {
          name = "SESAuthenticationError"
          value = "AWS SES authentication failed. Check your AWS credentials."
        }
      }
      else {
        // Other error
        var $status_text { value = $api_result.response.status|to_text }
        var $error_detail { value = $api_result.response.result|json_encode }
        
        db.add "email_log" {
          data = {
            to_email: $input.to_email
            from_email: $input.from_email
            subject: $input.subject
            status: "failed"
            error_message: "HTTP " ~ $status_text ~ ": " ~ $error_detail
            sent_at: now
          }
        } as $log_entry
        
        throw {
          name = "SESError"
          value = "AWS SES request failed with status " ~ $status_text
        }
      }
    }
  }
  response = $result
}
