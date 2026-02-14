function "create_one_off_event_type" {
  description = "Create a Calendly one-off event type (single-use scheduling link)"
  input {
    text name filters=trim { description = "Name of the event/meeting" }
    int duration filters=min:1|max:300 { description = "Duration in minutes (1-300)" }
    text timezone?="America/Los_Angeles" filters=trim { description = "Timezone for the event (e.g., America/Los_Angeles)" }
    text location_type?="zoom" filters=trim { description = "Location type: zoom, google_meet, microsoft_teams, in_person, phone, ask_invitee, or custom" }
    text custom_location? filters=trim { description = "Custom location URL or address (required if location_type is custom)" }
    text guest_email? filters=trim { description = "Pre-fill guest email (optional)" }
    text guest_name? filters=trim { description = "Pre-fill guest name (optional)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.CALENDLY_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "CALENDLY_API_KEY environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.name != null && $input.name != "") {
      error_type = "inputerror"
      error = "Event name is required"
    }

    precondition ($input.duration != null && $input.duration > 0) {
      error_type = "inputerror"
      error = "Duration is required and must be greater than 0"
    }

    // Get the user's URI first (required for creating one-off event)
    api.request {
      url = "https://api.calendly.com/users/me"
      method = "GET"
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $user_result

    // Check user request success
    precondition ($user_result.response.status == 200) {
      error_type = "standard"
      error = "Failed to get Calendly user information. Check your API key."
    }

    var $user_uri { value = $user_result.response.result.resource.uri }
    var $user_email { value = $user_result.response.result.resource.email }

    // Build the request payload for one-off event type
    var $payload {
      value = {
        name: $input.name,
        host: $user_uri,
        duration: $input.duration,
        timezone: $input.timezone
      }
    }

    // Add location based on type
    conditional {
      if ($input.location_type == "zoom") {
        var.update $payload {
          value = $payload|set:"location":{
            kind: "zoom_conference"
          }
        }
      }
      elseif ($input.location_type == "google_meet") {
        var.update $payload {
          value = $payload|set:"location":{
            kind: "google_conference"
          }
        }
      }
      elseif ($input.location_type == "microsoft_teams") {
        var.update $payload {
          value = $payload|set:"location":{
            kind: "microsoft_teams_conference"
          }
        }
      }
      elseif ($input.location_type == "phone") {
        var.update $payload {
          value = $payload|set:"location":{
            kind: "phone"
          }
        }
      }
      elseif ($input.location_type == "ask_invitee") {
        var.update $payload {
          value = $payload|set:"location":{
            kind: "ask_invitee"
          }
        }
      }
      elseif ($input.location_type == "custom") {
        precondition ($input.custom_location != null && $input.custom_location != "") {
          error_type = "inputerror"
          error = "Custom location is required when location_type is 'custom'"
        }
        var.update $payload {
          value = $payload|set:"location":{
            kind: "custom",
            location: $input.custom_location
          }
        }
      }
      else {
        // Default to ask_invitee if unknown type
        var.update $payload {
          value = $payload|set:"location":{
            kind: "ask_invitee"
          }
        }
      }
    }

    // Create the one-off event type
    api.request {
      url = "https://api.calendly.com/one_off_event_types"
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $api_key
      ]
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $booking_url { value = null }
    var $event_type_id { value = null }
    var $error_message { value = null }
    var $expires_at { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 201) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $event_type_resource { value = $response_body|get:"resource" }
        var $booking_url { value = $event_type_resource|get:"booking_url" }
        var $event_type_id { value = $event_type_resource|get:"id" }
        var $expires_at { value = $event_type_resource|get:"expires_at" }

        // Append guest info to URL if provided
        conditional {
          if ($input.guest_email != null && $input.guest_email != "" && $input.guest_name != null && $input.guest_name != "") {
            var $booking_url {
              value = $booking_url ~ "?email=" ~ ($input.guest_email|url_encode) ~ "&name=" ~ ($input.guest_name|url_encode)
            }
          }
          elseif ($input.guest_email != null && $input.guest_email != "") {
            var $booking_url {
              value = $booking_url ~ "?email=" ~ ($input.guest_email|url_encode)
            }
          }
          elseif ($input.guest_name != null && $input.guest_name != "") {
            var $booking_url {
              value = $booking_url ~ "?name=" ~ ($input.guest_name|url_encode)
            }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Calendly API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"error" }
            conditional {
              if ($error_obj != null) {
                var $error_details { value = $error_obj|get:"details" }
                conditional {
                  if ($error_details != null && ($error_details|count) > 0) {
                    var $first_error { value = $error_details|first }
                    var $error_message {
                      value = $first_error|get:"message"
                    }
                  }
                  else {
                    var $error_message {
                      value = $error_obj|get:"message"
                    }
                  }
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
    booking_url: $booking_url,
    event_type_id: $event_type_id,
    expires_at: $expires_at,
    host_email: $user_email,
    error: $error_message
  }
}
