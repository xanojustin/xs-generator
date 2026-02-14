function "track_event" {
  description = "Track an analytics event using the Segment API"
  input {
    text event filters=trim { description = "Event name to track (e.g., 'User Signed Up')" }
    text user_id? filters=trim { description = "Unique identifier for the user (optional, either user_id or anonymous_id required)" }
    text anonymous_id? filters=trim { description = "Anonymous identifier for users without an account (optional)" }
    json properties?
    json context?
    text timestamp? filters=trim { description = "ISO 8601 timestamp for when event occurred (optional, defaults to now)" }
    json integrations?
  }

  stack {
    // Get API key from environment
    var $write_key { value = $env.SEGMENT_WRITE_KEY }

    // Validate API key is configured
    precondition ($write_key != null && $write_key != "") {
      error_type = "standard"
      error = "SEGMENT_WRITE_KEY environment variable not configured"
    }

    // Validate event name is provided
    precondition ($input.event != null && $input.event != "") {
      error_type = "inputerror"
      error = "Event name is required"
    }

    // Validate that at least one identifier is provided
    precondition ($input.user_id != null || $input.anonymous_id != null) {
      error_type = "inputerror"
      error = "Either user_id or anonymous_id must be provided"
    }

    // Build the request payload
    var $payload {
      value = {
        event: $input.event,
        type: "track"
      }
    }

    // Add user_id if provided
    conditional {
      if ($input.user_id != null && $input.user_id != "") {
        var.update $payload {
          value = $payload|set:"userId":$input.user_id
        }
      }
    }

    // Add anonymous_id if provided
    conditional {
      if ($input.anonymous_id != null && $input.anonymous_id != "") {
        var.update $payload {
          value = $payload|set:"anonymousId":$input.anonymous_id
        }
      }
    }

    // Add properties if provided
    conditional {
      if ($input.properties != null) {
        var.update $payload {
          value = $payload|set:"properties":$input.properties
        }
      }
    }

    // Add context if provided
    conditional {
      if ($input.context != null) {
        var.update $payload {
          value = $payload|set:"context":$input.context
        }
      }
    }

    // Add timestamp if provided
    conditional {
      if ($input.timestamp != null && $input.timestamp != "") {
        var.update $payload {
          value = $payload|set:"timestamp":$input.timestamp
        }
      }
    }

    // Add integrations if provided
    conditional {
      if ($input.integrations != null) {
        var.update $payload {
          value = $payload|set:"integrations":$input.integrations
        }
      }
    }

    // Send the request to Segment Track API
    api.request {
      url = "https://api.segment.io/v1/track"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Basic " ~ ($write_key|concat:":"|base64_encode)
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $message { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $success { value = true }
        var $message { value = "Event tracked successfully" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Segment API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $response_text { value = $api_result.response.result|json_encode }
            var $error_message {
              value = $error_message ~ " - " ~ $response_text
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    message: $message,
    error: $error_message
  }
}