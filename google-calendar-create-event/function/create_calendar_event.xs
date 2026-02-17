function "create_calendar_event" {
  description = "Create an event in Google Calendar using the Google Calendar API"
  input {
    text summary { description = "Title/summary of the calendar event" }
    text description { description = "Description or details of the event" }
    text start_time { description = "Start time in ISO 8601 format (e.g., '2026-02-20T10:00:00')" }
    text end_time { description = "End time in ISO 8601 format (e.g., '2026-02-20T11:00:00')" }
    text timezone { description = "Timezone for the event (e.g., 'America/Los_Angeles')" }
  }
  stack {
    var $calendar_id { value = $env.google_calendar_id ?? "primary" }

    var $payload {
      value = {
        summary: $input.summary,
        description: $input.description,
        start: {
          dateTime: $input.start_time,
          timeZone: $input.timezone
        },
        end: {
          dateTime: $input.end_time,
          timeZone: $input.timezone
        },
        reminders: {
          useDefault: false,
          overrides: [
            { method: "email", minutes: 15 },
            { method: "popup", minutes: 10 }
          ]
        }
      }
    }

    var $url {
      value = "https://www.googleapis.com/calendar/v3/calendars/" ~ $calendar_id ~ "/events"
    }

    api.request {
      url = $url
      method = "POST"
      params = $payload
      headers = [
        "Authorization: Bearer " ~ $env.google_access_token,
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $event { value = $api_result.response.result }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "GoogleAuthError"
          value = "Authentication failed. Access token may be expired or invalid."
        }
      }
      elseif ($api_result.response.status == 403) {
        throw {
          name = "GooglePermissionError"
          value = "Permission denied. Ensure your access token has calendar.events scope."
        }
      }
      else {
        throw {
          name = "GoogleCalendarAPIError"
          value = "Google Calendar API returned status " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
        }
      }
    }
  }
  response = $event
}
