function "create_calendar_event" {
  description = "Creates a new event in Google Calendar using the Google Calendar API"
  input {
    text summary { description = "Event title/summary" }
    text description { description = "Event description" }
    text start_time { description = "Start time in ISO 8601 format (e.g., 2026-02-20T10:00:00-08:00)" }
    text end_time { description = "End time in ISO 8601 format (e.g., 2026-02-20T11:00:00-08:00)" }
    text[] attendees? { description = "List of attendee email addresses" }
  }
  stack {
    // Build the request body for Google Calendar API
    var $event_body {
      value = {
        summary: $input.summary
        description: $input.description
        start: {
          dateTime: $input.start_time
          timeZone: "America/Los_Angeles"
        }
        end: {
          dateTime: $input.end_time
          timeZone: "America/Los_Angeles"
        }
      }
    }

    // Add attendees if provided
    conditional {
      if (`$input.attendees != null && ($input.attendees|count) > 0`) {
        var $attendee_list { value = [] }
        foreach ($input.attendees) {
          each as $email {
            var $attendee_obj { value = { email: $email } }
            var $attendee_list { value = $attendee_list ~ [$attendee_obj] }
          }
        }
        var $event_body {
          value = ($event_body|set:"attendees":$attendee_list)
        }
      }
    }

    // Get calendar ID from environment or use primary
    conditional {
      if (`$env.GOOGLE_CALENDAR_ID != null && $env.GOOGLE_CALENDAR_ID != ""`) {
        var $calendar_id { value = $env.GOOGLE_CALENDAR_ID }
      }
      else {
        var $calendar_id { value = "primary" }
      }
    }

    // Make API request to Google Calendar
    api.request {
      url = "https://www.googleapis.com/calendar/v3/calendars/" ~ ($calendar_id|url_encode) ~ "/events"
      method = "POST"
      params = $event_body
      headers = [
        "Content-Type: application/json"
        "Authorization: Bearer " ~ $env.GOOGLE_CALENDAR_API_KEY
      ]
    } as $api_result

    // Check for successful response
    precondition (`$api_result.response.status >= 200 && $api_result.response.status < 300`) {
      error_type = "standard"
      error = "Google Calendar API request failed: " ~ ($api_result.response|json_encode)
    }

    // Extract the created event details
    var $created_event {
      value = $api_result.response.result
    }

    // Log success
    var $log_message {
      value = "Event created successfully: " ~ ($created_event|get:"htmlLink")
    }
  }
  response = {
    success: true
    event_id: ($created_event|get:"id")
    event_link: ($created_event|get:"htmlLink")
    summary: ($created_event|get:"summary")
    start: ($created_event|get:"start")
    end: ($created_event|get:"end")
    created: ($created_event|get:"created")
  }
}
