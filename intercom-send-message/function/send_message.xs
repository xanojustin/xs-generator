function "send_message" {
  description = "Send a message to a contact via Intercom API"
  input {
    text message_body filters=trim { description = "The message body/content to send" }
    text message_type?="email" filters=trim { description = "Message type: email, inapp, or sms (default: email)" }
    text to_user_id? filters=trim { description = "Intercom user ID to send message to (optional)" }
    text to_contact_id? filters=trim { description = "Intercom contact ID to send message to (optional)" }
    text to_email? filters=trim { description = "Email address of recipient (optional, for new contacts)" }
    text subject? filters=trim { description = "Subject line for email messages (optional)" }
    text template_id? filters=trim { description = "Intercom template ID to use (optional)" }
    text use_template?="false" filters=trim { description = "Whether to use a template - 'true' or 'false' (default: 'false')" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.INTERCOM_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "INTERCOM_API_KEY environment variable not configured"
    }

    // Validate message body is provided
    precondition ($input.message_body != null && $input.message_body != "") {
      error_type = "inputerror"
      error = "Message body is required"
    }

    // Validate at least one recipient identifier is provided
    precondition (($input.to_user_id != null && $input.to_user_id != "") || ($input.to_contact_id != null && $input.to_contact_id != "") || ($input.to_email != null && $input.to_email != "")) {
      error_type = "inputerror"
      error = "At least one recipient identifier is required: to_user_id, to_contact_id, or to_email"
    }

    // Build the recipient object
    var $recipient {
      value = {}
    }

    // Add user_id if provided
    conditional {
      if ($input.to_user_id != null && $input.to_user_id != "") {
        var.update $recipient {
          value = $recipient|set:"user_id":$input.to_user_id
        }
      }
    }

    // Add contact_id if provided
    conditional {
      if ($input.to_contact_id != null && $input.to_contact_id != "") {
        var.update $recipient {
          value = $recipient|set:"contact_id":$input.to_contact_id
        }
      }
    }

    // Add email if provided (creates or updates contact)
    conditional {
      if ($input.to_email != null && $input.to_email != "") {
        var.update $recipient {
          value = $recipient|set:"email":$input.to_email
        }
      }
    }

    // Build the request payload based on message type
    var $payload {
      value = {
        message_type: $input.message_type,
        body: $input.message_body,
        to: $recipient
      }
    }

    // Add subject if provided (for email messages)
    conditional {
      if ($input.subject != null && $input.subject != "") {
        var.update $payload {
          value = $payload|set:"subject":$input.subject
        }
      }
    }

    // Add template if using template
    conditional {
      if ($input.use_template == "true" && $input.template_id != null && $input.template_id != "") {
        var.update $payload {
          value = $payload|set:"template_id":$input.template_id
        }
      }
    }

    // Send the request to Intercom
    api.request {
      url = "https://api.intercom.io/messages"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key,
        "Intercom-Version: 2.11"
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $message_id { value = null }
    var $conversation_id { value = null }
    var $error_message { value = null }
    var $response_type { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200 || $api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $message_id { value = $response_body|get:"id" }
        var $response_type { value = $response_body|get:"type" }

        // Extract conversation ID if available (it's nested in conversation object)
        var $conversation_obj { value = $response_body|get:"conversation" }
        conditional {
          if ($conversation_obj != null) {
            var $conversation_id { value = $conversation_obj|get:"id" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Intercom API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"errors" }
            conditional {
              if ($error_obj != null && ($error_obj|is_array)) {
                var $first_error { value = $error_obj|first }
                conditional {
                  if ($first_error != null) {
                    var $error_message {
                      value = $first_error|get:"message"
                    }
                  }
                }
              }
              elseif ($api_result.response.result|get:"message" != null) {
                var $error_message {
                  value = $api_result.response.result|get:"message"
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    message_id: $message_id,
    conversation_id: $conversation_id,
    type: $response_type,
    error: $error_message
  }
}
