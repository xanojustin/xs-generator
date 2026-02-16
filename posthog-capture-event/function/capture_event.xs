function "capture_event" {
  description = "Capture an event to PostHog analytics"
  input {
    text event filters=trim { description = "Event name (e.g., page_view, user_signed_up)" }
    text distinct_id filters=trim { description = "Unique identifier for the user (e.g., user ID, email, or UUID)" }
    json properties? { description = "Optional event properties as key-value pairs" }
    text timestamp? filters=trim { description = "Optional ISO 8601 timestamp (defaults to now)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.POSTHOG_API_KEY }
    var $host { value = $env.POSTHOG_HOST ?? "https://us.posthog.com" }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "POSTHOG_API_KEY environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.event != null && $input.event != "") {
      error_type = "inputerror"
      error = "Event name is required"
    }

    precondition ($input.distinct_id != null && $input.distinct_id != "") {
      error_type = "inputerror"
      error = "Distinct ID is required"
    }

    // Build the request payload
    var $payload {
      value = {
        api_key: $api_key,
        event: $input.event,
        distinct_id: $input.distinct_id,
        properties: {}
      }
    }

    // Add timestamp if provided, otherwise PostHog uses current time
    conditional {
      if ($input.timestamp != null && $input.timestamp != "") {
        var.update $payload {
          value = $payload|set:"timestamp":$input.timestamp
        }
      }
    }

    // Merge provided properties with default properties
    conditional {
      if ($input.properties != null) {
        var.update $payload {
          value = $payload|set:"properties":$input.properties
        }
      }
    }

    // Send the request to PostHog
    api.request {
      url = $host ~ "/capture/"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $success { value = true }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "PostHog API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_detail { value = $api_result.response.result|json_encode }
            conditional {
              if ($error_detail != null && $error_detail != "") {
                var $error_message {
                  value = $error_message ~ " - " ~ $error_detail
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
    event: $input.event,
    distinct_id: $input.distinct_id,
    error: $error_message
  }
}