function "send_notification" {
  description = "Send a notification using Courier API to multiple channels"
  input {
    text user_id filters=trim { description = "Unique identifier for the recipient user" }
    text template filters=trim { description = "Courier template ID or event name" }
    text channel?="email" filters=trim { description = "Preferred channel: email, sms, push, or chat (default: email)" }
    json data? { description = "Dynamic data to populate the template variables" }
    text brand_id? filters=trim { description = "Optional brand ID for white-label notifications" }
    json override? { description = "Optional provider overrides for the notification" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.COURIER_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "COURIER_API_KEY environment variable not configured"
    }

    // Validate required fields
    precondition ($input.user_id != null && $input.user_id != "") {
      error_type = "inputerror"
      error = "user_id is required"
    }

    precondition ($input.template != null && $input.template != "") {
      error_type = "inputerror"
      error = "template is required"
    }

    // Build the request payload for Courier API
    var $payload {
      value = {
        message: {
          to: {
            user_id: $input.user_id
          },
          template: $input.template,
          data: $input.data
        }
      }
    }

    // Add routing preference if channel is specified
    conditional {
      if ($input.channel != null && $input.channel != "") {
        var $routing {
          value = {
            method: "single",
            channels: [$input.channel]
          }
        }
        var $message_obj { value = $payload|get:"message" }
        var.update $message_obj {
          value = $message_obj|set:"routing":$routing
        }
        var.update $payload {
          value = $payload|set:"message":$message_obj
        }
      }
    }

    // Add brand_id if provided
    conditional {
      if ($input.brand_id != null && $input.brand_id != "") {
        var $message_obj { value = $payload|get:"message" }
        var.update $message_obj {
          value = $message_obj|set:"brand":$input.brand_id
        }
        var.update $payload {
          value = $payload|set:"message":$message_obj
        }
      }
    }

    // Add provider overrides if provided
    conditional {
      if ($input.override != null && ($input.override|json_encode) != "{}") {
        var $message_obj { value = $payload|get:"message" }
        var.update $message_obj {
          value = $message_obj|set:"override":$input.override
        }
        var.update $payload {
          value = $payload|set:"message":$message_obj
        }
      }
    }

    // Send the request to Courier API
    api.request {
      url = "https://api.courier.com/send"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $request_id { value = null }
    var $status { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $request_id { value = $response_body|get:"requestId" }
        var $status { value = "sent" }
      }
      else {
        var $success { value = false }
        var $error_body { value = $api_result.response.result }
        var $error_msg { value = $error_body|get:"message" }
        
        conditional {
          if ($error_msg != null) {
            var $error_message { value = "Courier API error: " ~ $error_msg }
          }
          else {
            var $error_message {
              value = "Courier API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    request_id: $request_id,
    status: $status,
    error: $error_message
  }
}
