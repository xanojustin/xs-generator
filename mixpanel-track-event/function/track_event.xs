function "track_event" {
  description = "Track an event in Mixpanel analytics"
  input {
    text event filters=trim { 
      description = "Event name to track (e.g., 'User Signup', 'Purchase Completed')" 
    }
    text distinct_id? filters=trim { 
      description = "Unique identifier for the user (optional)" 
    }
    text properties? filters=trim { 
      description = "JSON string with event properties (optional, e.g., plan:pro, amount:99)" 
    }
    text ip? filters=trim { 
      description = "IP address of the user (optional, for geolocation)" 
    }
    text time? filters=trim { 
      description = "Unix timestamp of the event (optional, defaults to now)" 
    }
  }

  stack {
    // Get API token from environment
    var $project_token { value = $env.MIXPANEL_PROJECT_TOKEN }

    // Validate API token is configured
    precondition ($project_token != null && $project_token != "") {
      error_type = "standard"
      error = "MIXPANEL_PROJECT_TOKEN environment variable not configured"
    }

    // Validate event name is provided
    precondition ($input.event != null && $input.event != "") {
      error_type = "inputerror"
      error = "Event name is required"
    }

    // Build the event properties object
    var $event_properties {
      value = {
        token: $project_token,
        time: $input.time ?? (now|to_int)
      }
    }

    // Add distinct_id if provided
    conditional {
      if ($input.distinct_id != null && $input.distinct_id != "") {
        var.update $event_properties {
          value = $event_properties|set:"distinct_id":$input.distinct_id
        }
      }
    }

    // Add IP for geolocation if provided
    conditional {
      if ($input.ip != null && $input.ip != "") {
        var.update $event_properties {
          value = $event_properties|set:"ip":$input.ip
        }
      }
    }

    // Parse and merge custom properties if provided
    conditional {
      if ($input.properties != null && $input.properties != "") {
        try_catch {
          try {
            var $custom_props { value = $input.properties|json_decode }
            var $merged_props { value = $event_properties|merge:$custom_props }
            var $event_properties { value = $merged_props }
          }
          catch {
            debug.log { value = "Failed to parse properties JSON: " ~ $input.properties }
          }
        }
      }
    }

    // Build the Mixpanel track payload
    var $track_data {
      value = [
        {
          event: $input.event,
          properties: $event_properties
        }
      ]
    }

    // Encode the payload as base64 (Mixpanel requirement)
    var $encoded_data {
      value = $track_data|json_encode|base64_encode
    }

    // Send the request to Mixpanel
    api.request {
      url = "https://api.mixpanel.com/track"
      method = "POST"
      params = { data: $encoded_data }
      headers = ["Content-Type: application/x-www-form-urlencoded"]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $error_message { value = null }
    var $response_status { value = $api_result.response.status }

    // Parse response
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        
        // Mixpanel returns 1 for success
        conditional {
          if ($response_body == 1 || $response_body == "1") {
            var $success { value = true }
          }
          else {
            var $success { value = false }
            var $error_message { 
              value = "Mixpanel returned error: " ~ ($response_body|to_text) 
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "HTTP error " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }

  response = {
    success: $success,
    event: $input.event,
    status_code: $response_status,
    error: $error_message
  }
}
