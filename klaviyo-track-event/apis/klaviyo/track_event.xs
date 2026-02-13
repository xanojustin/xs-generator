query "track_event" verb=POST {
  description = "Track a custom event in Klaviyo for a user. Creates/updates the profile and records the event."

  input {
    email email {
      description = "User's email address"
      sensitive = false
    }

    text event_name filters=trim {
      description = "Name of the event to track (e.g., 'Product Purchased', 'Signed Up')"
      sensitive = false
    }

    timestamp timestamp? {
      description = "Optional event timestamp (ISO format). Defaults to current time."
      sensitive = false
    }

    json properties? {
      description = "Optional event properties as JSON object"
      sensitive = false
    }

    json profile_properties? {
      description = "Optional profile attributes (first_name, last_name, phone, etc.)"
      sensitive = false
    }
  }

  stack {
    precondition ($input.event_name != null && $input.event_name != "") {
      description = "Validate event_name is provided"
      error_type = "inputerror"
      error = "event_name is required"
    }

    var $event_timestamp {
      description = "Use provided timestamp or default to now"
      value = $input.timestamp
    }

    conditional {
      description = "Set default timestamp if not provided"
      if ($event_timestamp == null) {
        var.update $event_timestamp {
          value = now
        }
      }
    }

    function.run "klaviyo_track_event" {
      description = "Call the Klaviyo track event function"
      input = {
        email: $input.email,
        event_name: $input.event_name,
        timestamp: $event_timestamp,
        properties: $input.properties,
        profile_properties: $input.profile_properties
      }
    } as $track_result

    conditional {
      description = "Handle tracking failure"
      if ($track_result.success == false) {
        throw {
          name = "KlaviyoError"
          value = "Failed to track event in Klaviyo"
        }
      }
    }

    var $response_data {
      description = "Build success response"
      value = {
        success: true,
        message: "Event tracked successfully",
        event_id: $track_result.event_id,
        email: $input.email,
        event_name: $input.event_name
      }
    }

    debug.log {
      description = "Log successful API request"
      value = {
        endpoint: "klaviyo/track_event",
        email: $input.email,
        event_name: $input.event_name,
        event_id: $track_result.event_id
      }
    }
  }

  response = $response_data

  history = 1000
}
