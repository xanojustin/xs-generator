function "track_event" {
  description = "Send an analytics event to Amplitude"
  input {
    text event_type filters=trim { description = "The name/type of the event (e.g., purchase, signup, page_view)" }
    text user_id filters=trim { description = "Unique user identifier (required if device_id not provided)" }
    text device_id filters=trim { description = "Device identifier (required if user_id not provided)" }
    text event_properties_json filters=trim { description = "JSON string containing event-specific properties" }
    text user_properties_json filters=trim { description = "JSON string containing user attributes to update" }
    text time_str filters=trim { description = "Event timestamp in milliseconds since epoch as string (defaults to now)" }
    text platform filters=trim { description = "Platform (e.g., iOS, Android, Web)" }
    text revenue_str filters=trim { description = "Revenue amount for purchase events as string" }
    text product_id filters=trim { description = "Product identifier for purchase events" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.AMPLITUDE_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "AMPLITUDE_API_KEY environment variable not configured"
    }

    // Validate event type is provided
    precondition ($input.event_type != null && $input.event_type != "") {
      error_type = "inputerror"
      error = "Event type is required"
    }

    // Parse event properties JSON if provided
    var $event_props { value = null }
    conditional {
      if ($input.event_properties_json != null && $input.event_properties_json != "") {
        var $event_props { value = $input.event_properties_json|json_decode }
      }
    }

    // Parse user properties JSON if provided
    var $user_props { value = null }
    conditional {
      if ($input.user_properties_json != null && $input.user_properties_json != "") {
        var $user_props { value = $input.user_properties_json|json_decode }
      }
    }

    // Get current timestamp
    var $now_ms { value = "now"|to_ms }

    // Parse time if provided, otherwise use current time
    var $event_time { value = $now_ms }
    conditional {
      if ($input.time_str != null && $input.time_str != "") {
        var $event_time { value = $input.time_str|to_int }
      }
    }

    // Parse revenue if provided
    var $revenue_val { value = null }
    conditional {
      if ($input.revenue_str != null && $input.revenue_str != "") {
        var $revenue_val { value = $input.revenue_str|to_decimal }
      }
    }

    // Build the event object
    var $event_obj {
      value = {
        event_type: $input.event_type,
        time: $event_time
      }
    }

    // Add user_id if provided
    conditional {
      if ($input.user_id != null && $input.user_id != "") {
        var.update $event_obj {
          value = $event_obj|set:"user_id":$input.user_id
        }
      }
    }

    // Add device_id if provided
    conditional {
      if ($input.device_id != null && $input.device_id != "") {
        var.update $event_obj {
          value = $event_obj|set:"device_id":$input.device_id
        }
      }
    }

    // Add platform if provided
    conditional {
      if ($input.platform != null && $input.platform != "") {
        var.update $event_obj {
          value = $event_obj|set:"platform":$input.platform
        }
      }
    }

    // Add event properties if provided
    conditional {
      if ($event_props != null) {
        var.update $event_obj {
          value = $event_obj|set:"event_properties":$event_props
        }
      }
    }

    // Add user properties if provided
    conditional {
      if ($user_props != null) {
        var.update $event_obj {
          value = $event_obj|set:"user_properties":$user_props
        }
      }
    }

    // Handle revenue tracking
    conditional {
      if ($revenue_val != null) {
        var $revenue_props { value = {} }
        var.update $revenue_props {
          value = $revenue_props|set:"$revenue":$revenue_val
        }
        conditional {
          if ($input.product_id != null && $input.product_id != "") {
            var.update $revenue_props {
              value = $revenue_props|set:"$productId":$input.product_id
            }
          }
        }
        // Merge revenue props into event properties
        var $existing_props { value = $event_obj|get:"event_properties" }
        conditional {
          if ($existing_props == null) {
            var $existing_props { value = {} }
          }
        }
        // Combine existing props with revenue props
        var $all_revenue_keys { value = $revenue_props|keys }
        for ($key in $all_revenue_keys) {
          var $val { value = $revenue_props|get:$key }
          var.update $existing_props {
            value = $existing_props|set:$key:$val
          }
        }
        var.update $event_obj {
          value = $event_obj|set:"event_properties":$existing_props
        }
      }
    }

    // Build the request payload
    var $payload {
      value = {
        api_key: $api_key,
        events: [$event_obj]
      }
    }

    // Send the request to Amplitude
    api.request {
      url = "https://api2.amplitude.com/2/httpapi"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $response_code { value = $api_result.response.status }
    var $error_message { value = null }
    var $events_ingested { value = 0 }
    var $payload_size { value = null }
    var $server_upload_time { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $events_ingested { value = $response_body|get:"events_ingested" }
        var $payload_size { value = $response_body|get:"payload_size_bytes" }
        var $server_upload_time { value = $response_body|get:"server_upload_time" }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Amplitude API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $response_body { value = $api_result.response.result }
            var $error_field { value = $response_body|get:"error" }
            conditional {
              if ($error_field != null) {
                var $error_message {
                  value = $error_field
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
    code: $response_code,
    events_ingested: $events_ingested,
    payload_size_bytes: $payload_size,
    server_upload_time: $server_upload_time,
    error: $error_message
  }
}
