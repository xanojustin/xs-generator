function "calendly_create_scheduling_link" {
  description = "Create a single-use scheduling link in Calendly"

  input {
    text event_type_uri filters=trim {
      description = "The URI of the event type (e.g., https://api.calendly.com/event_types/ABC123)"
    }

    int max_event_count?=1 {
      description = "Maximum number of times this link can be used (default: 1)"
    }
  }

  stack {
    precondition (($input.event_type_uri|is_empty) == false) {
      error_type = "inputerror"
      error = "Event type URI is required"
    }

    precondition ($input.max_event_count > 0) {
      error_type = "inputerror"
      error = "Max event count must be greater than 0"
    }

    precondition (($env.calendly_api_token|is_empty) == false) {
      error_type = "standard"
      error = "Calendly API token not configured. Please set calendly_api_token environment variable."
    }

    var $request_body {
      value = {
        max_event_count: $input.max_event_count,
        owner: $input.event_type_uri,
        owner_type: "EventType"
      }
    }

    api.request {
      description = "Create single-use scheduling link via Calendly API"
      url = "https://api.calendly.com/scheduling_links"
      method = "POST"
      params = $request_body
      headers = [
        "Authorization: Bearer " ~ $env.calendly_api_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_response

    var $response_status {
      value = $api_response.response.status
    }

    precondition ($response_status == 200 || $response_status == 201) {
      error_type = "standard"
      error = "Calendly API error: HTTP " ~ $response_status ~ " - " ~ ($api_response.response.body.message ?? "Unknown error")
    }

    var $scheduling_link {
      value = $api_response.response.body.resource
    }

    var $result {
      value = {
        success: true,
        scheduling_link: {
          url: $scheduling_link.booking_url,
          expires_at: $scheduling_link.expires_at,
          max_event_count: $scheduling_link.max_event_count,
          remaining_event_count: $scheduling_link.remaining_event_count
        },
        message: "Scheduling link created successfully"
      }
    }
  }

  response = $result
}
