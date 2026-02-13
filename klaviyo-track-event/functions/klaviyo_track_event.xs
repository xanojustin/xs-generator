function "klaviyo_track_event" {
  description = "Track a custom event in Klaviyo. Creates/updates the profile and records the event in one call."

  input {
    email email {
      description = "User's email address (required)"
      sensitive = false
    }

    text event_name filters=trim {
      description = "Name of the event to track (e.g., 'Product Purchased')"
      sensitive = false
    }

    timestamp timestamp?=now {
      description = "Event timestamp (defaults to current time)"
      sensitive = false
    }

    json properties? {
      description = "Event properties as JSON object (e.g., product details, values)"
      sensitive = false
    }

    json profile_properties? {
      description = "Profile attributes to include (first_name, last_name, phone, etc.)"
      sensitive = false
    }
  }

  stack {
    var $klaviyo_base_url {
      description = "Klaviyo API base URL from environment"
      value = $env.KLAVIYO_BASE_URL
    }

    var $api_key {
      description = "Klaviyo API key from environment"
      value = $env.KLAVIYO_API_KEY
    }

    precondition ($klaviyo_base_url != null && $klaviyo_base_url != "") {
      description = "Validate KLAVIYO_BASE_URL environment variable is set"
      error_type = "standard"
      error = "KLAVIYO_BASE_URL environment variable is not configured"
    }

    precondition ($api_key != null && $api_key != "") {
      description = "Validate KLAVIYO_API_KEY environment variable is set"
      error_type = "standard"
      error = "KLAVIYO_API_KEY environment variable is not configured"
    }

    precondition ($input.event_name != null && $input.event_name != "") {
      description = "Validate event_name is provided"
      error_type = "inputerror"
      error = "event_name is required to track an event"
    }

    var $event_attributes {
      description = "Build the event attributes object"
      value = {
        metric: {
          data: {
            type: "metric",
            attributes: {
              name: $input.event_name
            }
          }
        },
        profile: {
          data: {
            type: "profile",
            attributes: {
              email: $input.email
            }
          }
        },
        timestamp: $input.timestamp|format_timestamp:"c":"UTC"
      }
    }

    conditional {
      description = "Add profile properties if provided"
      if ($input.profile_properties != null) {
        var $profile_attrs {
          description = "Start with email"
          value = $event_attributes.event_attributes.profile.data.attributes
        }

        conditional {
          description = "Add first_name if in profile_properties"
          if ($input.profile_properties.first_name != null) {
            var.update $profile_attrs {
              value = $profile_attrs|set:"first_name":$input.profile_properties.first_name
            }
          }
        }

        conditional {
          description = "Add last_name if in profile_properties"
          if ($input.profile_properties.last_name != null) {
            var.update $profile_attrs {
              value = $profile_attrs|set:"last_name":$input.profile_properties.last_name
            }
          }
        }

        conditional {
          description = "Add phone if in profile_properties"
          if ($input.profile_properties.phone != null) {
            var.update $profile_attrs {
              value = $profile_attrs|set:"phone_number":$input.profile_properties.phone
            }
          }
        }

        conditional {
          description = "Add external_id if in profile_properties"
          if ($input.profile_properties.external_id != null) {
            var.update $profile_attrs {
              value = $profile_attrs|set:"external_id":$input.profile_properties.external_id
            }
          }
        }

        var.update $event_attributes {
          value = $event_attributes|set:"profile":({"data":{"type":"profile","attributes":$profile_attrs}})
        }
      }
    }

    conditional {
      description = "Add event properties if provided"
      if ($input.properties != null) {
        var.update $event_attributes {
          value = $event_attributes|set:"properties":$input.properties
        }
      }
    }

    var $event_payload {
      description = "Build the complete event payload"
      value = {
        data: {
          type: "event",
          attributes: $event_attributes
        }
      }
    }

    var $request_url {
      description = "Build the Klaviyo events API URL"
      value = $klaviyo_base_url ~ "/events/"
    }

    debug.log {
      description = "Log event tracking attempt"
      value = {
        action: "klaviyo_track_event",
        email: $input.email,
        event_name: $input.event_name,
        url: $request_url
      }
    }

    api.request {
      description = "Send event data to Klaviyo API"
      url = $request_url
      method = "POST"
      headers = []|push:"Authorization: Klaviyo-API-Key " ~ $api_key|push:"Content-Type: application/json"|push:"revision: 2025-01-15"
      params = $event_payload
      timeout = 30
    } as $api_response

    var $success {
      description = "Determine if the API call was successful"
      value = $api_response.status_code >= 200 && $api_response.status_code < 300
    }

    var $event_id {
      description = "Extract Klaviyo event ID from response"
      value = ""
    }

    conditional {
      description = "Extract event ID if response contains data"
      if ($success && $api_response.response.data != null) {
        var.update $event_id {
          value = $api_response.response.data.id
        }
      }
    }

    debug.log {
      description = "Log event tracking result"
      value = {
        action: "klaviyo_track_event_complete",
        email: $input.email,
        event_name: $input.event_name,
        success: $success,
        event_id: $event_id,
        status_code: $api_response.status_code
      }
    }

    var $result {
      description = "Build the function result"
      value = {
        success: $success,
        event_id: $event_id,
        response: $api_response.response
      }
    }
  }

  response = $result
}
