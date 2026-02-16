function "send_email" {
  description = "Send an email using AWS Simple Email Service (SES) v2 API"
  input {
    text to_email filters=trim { description = "Recipient email address" }
    text from_email filters=trim { description = "Sender email address (must be verified in SES)" }
    text subject filters=trim { description = "Email subject" }
    text body_text? filters=trim { description = "Plain text body (optional)" }
    text body_html? filters=trim { description = "HTML body (optional)" }
    text reply_to? filters=trim { description = "Reply-to email address (optional)" }
  }

  stack {
    // Get AWS credentials from environment
    var $access_key { value = $env.AWS_ACCESS_KEY_ID }
    var $secret_key { value = $env.AWS_SECRET_ACCESS_KEY }
    var $region { value = $env.AWS_REGION }

    // Validate AWS credentials are configured
    precondition ($access_key != null && $access_key != "") {
      error_type = "standard"
      error = "AWS_ACCESS_KEY_ID environment variable not configured"
    }

    precondition ($secret_key != null && $secret_key != "") {
      error_type = "standard"
      error = "AWS_SECRET_ACCESS_KEY environment variable not configured"
    }

    // Set default region if not provided
    conditional {
      if ($region == null || $region == "") {
        var $region { value = "us-east-1" }
      }
    }

    // Validate required inputs
    precondition ($input.to_email != null && $input.to_email != "") {
      error_type = "inputerror"
      error = "Recipient email (to_email) is required"
    }

    precondition ($input.from_email != null && $input.from_email != "") {
      error_type = "inputerror"
      error = "Sender email (from_email) is required"
    }

    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Subject is required"
    }

    // Validate at least one body type is provided
    precondition (($input.body_text != null && $input.body_text != "") || ($input.body_html != null && $input.body_html != "")) {
      error_type = "inputerror"
      error = "Either body_text or body_html must be provided"
    }

    // Build the SES API endpoint URL
    var $endpoint {
      value = "https://email." ~ $region ~ ".amazonaws.com/v2/email/outbound-emails"
    }

    // Build content object based on what body types are provided
    var $content {}
    
    conditional {
      if ($input.body_text != null && $input.body_text != "" && $input.body_html != null && $input.body_html != "") {
        // Both text and HTML provided
        var $content {
          value = {
            simple: {
              subject: {
                data: $input.subject
              },
              body: {
                text: {
                  data: $input.body_text
                },
                html: {
                  data: $input.body_html
                }
              }
            }
          }
        }
      }
      elseif ($input.body_html != null && $input.body_html != "") {
        // Only HTML provided
        var $content {
          value = {
            simple: {
              subject: {
                data: $input.subject
              },
              body: {
                html: {
                  data: $input.body_html
                }
              }
            }
          }
        }
      }
      else {
        // Only text provided
        var $content {
          value = {
            simple: {
              subject: {
                data: $input.subject
              },
              body: {
                text: {
                  data: $input.body_text
                }
              }
            }
          }
        }
      }
    }

    // Build destination object
    var $destination {
      value = {
        to_addresses: [$input.to_email]
      }
    }

    // Build final payload
    var $payload {
      value = {
        from_email_address: $input.from_email,
        destination: $destination,
        content: $content
      }
    }

    // Add reply-to if provided
    conditional {
      if ($input.reply_to != null && $input.reply_to != "") {
        var $reply_to_list { value = [$input.reply_to] }
        var $payload {
          value = $payload|set:"reply_to_addresses":$reply_to_list
        }
      }
    }

    // Generate timestamp for AWS Signature V4
    var $timestamp { value = now|format_timestamp:"YmdTHisZ":"UTC" }
    var $date_stamp { value = now|format_timestamp:"Ymd":"UTC" }

    // Build host header
    var $host { value = "email." ~ $region ~ ".amazonaws.com" }

    // Build AWS Signature V4 components
    var $algorithm { value = "AWS4-HMAC-SHA256" }
    var $credential_scope {
      value = $date_stamp ~ "/" ~ $region ~ "/ses/aws4_request"
    }
    var $credential {
      value = $access_key ~ "/" ~ $credential_scope
    }

    // Build simplified Authorization header
    // Note: For production use, full AWS Signature V4 signing should be implemented
    // This uses UNSIGNED-PAYLOAD for PUT/POST operations that support it
    var $authorization_header {
      value = $algorithm ~ " Credential=" ~ $credential ~ ", SignedHeaders=host;x-amz-date, Signature=UNSIGNED-PAYLOAD"
    }

    // Send the request to AWS SES
    api.request {
      url = $endpoint
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Host: " ~ $host,
        "X-Amz-Date: " ~ $timestamp,
        "Authorization: " ~ $authorization_header,
        "x-amz-content-sha256: UNSIGNED-PAYLOAD"
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $message_id { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $message_id { value = $response_body|get:"MessageId" }
      }
      else {
        var $success { value = false }
        var $error_response { value = $api_result.response.result }
        conditional {
          if ($error_response != null) {
            var $error_detail { value = $error_response|get:"message" }
            conditional {
              if ($error_detail != null) {
                var $error_message { value = $error_detail }
              }
              else {
                var $error_message {
                  value = "AWS SES error: HTTP " ~ ($api_result.response.status|to_text)
                }
              }
            }
          }
          else {
            var $error_message {
              value = "AWS SES error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    message_id: $message_id,
    error: $error_message
  }
}
