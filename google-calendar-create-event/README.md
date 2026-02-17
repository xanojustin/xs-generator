# Google Calendar Create Event - Xano Run Job

This Xano Run Job creates events in Google Calendar using the Google Calendar API. It demonstrates how to integrate with Google's calendar service from Xano.

## What This Run Job Does

The `Google Calendar Create Event` run job creates a calendar event by:
1. Accepting event details (title, description, start/end times, timezone)
2. Making an authenticated request to Google Calendar's `/v3/calendars/{calendarId}/events` endpoint
3. Returning the created event object with details like event ID, HTML link, and creation timestamp

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `google_access_token` | OAuth 2.0 access token with calendar scope | `ya29.a0Ae4...` |
| `google_calendar_id` | ID of the calendar to add events to (optional, defaults to "primary") | `primary` or `abc123@group.calendar.google.com` |

### Getting Your Google Access Token

1. Go to the [Google OAuth 2.0 Playground](https://developers.google.com/oauthplayground)
2. Click the gear icon (settings) and check "Use your own OAuth credentials"
3. Enter your OAuth client ID and secret (create one at [Google Cloud Console](https://console.cloud.google.com/apis/credentials) if needed)
4. Select the scope: `https://www.googleapis.com/auth/calendar`
5. Click "Authorize APIs" and authenticate with your Google account
6. Click "Exchange authorization code for tokens"
7. Copy the **Access token** for use in your environment variable

### Creating OAuth Credentials

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Navigate to **APIs & Services** → **Credentials**
4. Click **Create Credentials** → **OAuth client ID**
5. Select **Desktop app** as the application type
6. Download the client credentials JSON file
7. Enable the Google Calendar API at **APIs & Services** → **Library**

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Google Calendar Create Event"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Google Calendar Create Event"
}
```

### Customizing the Event

Edit the `input` block in `run.xs`:

```xs
run.job "Google Calendar Create Event" {
  main = {
    name: "create_calendar_event"
    input: {
      summary: "Product Launch Meeting"
      description: "Discuss the Q2 product launch strategy and marketing plan."
      start_time: "2026-03-15T14:00:00"
      end_time: "2026-03-15T15:30:00"
      timezone: "America/New_York"
    }
  }
  env = ["google_access_token", "google_calendar_id"]
}
```

### Timezone Values

Common timezone values for the `timezone` field:
- `America/Los_Angeles` - Pacific Time
- `America/New_York` - Eastern Time
- `America/Chicago` - Central Time
- `America/Denver` - Mountain Time
- `Europe/London` - London Time
- `Europe/Paris` - Central European Time
- `Asia/Tokyo` - Japan Time
- `UTC` - Coordinated Universal Time

## File Structure

```
google-calendar-create-event/
├── run.xs                              # Run job configuration
├── function/
│   └── create_calendar_event.xs        # Function that calls Google Calendar API
└── README.md                           # This file
```

## Response Format

On success, the function returns a Google Calendar Event object:

```json
{
  "kind": "calendar#event",
  "etag": "\"abc123\"",
  "id": "abc123def456ghi789",
  "status": "confirmed",
  "htmlLink": "https://www.google.com/calendar/event?eid=...",
  "created": "2026-02-17T10:30:00.000Z",
  "updated": "2026-02-17T10:30:00.000Z",
  "summary": "Team Meeting - Xano Project Review",
  "description": "Weekly sync to discuss Xano development progress and upcoming milestones.",
  "creator": {
    "email": "user@example.com",
    "self": true
  },
  "organizer": {
    "email": "user@example.com",
    "self": true
  },
  "start": {
    "dateTime": "2026-02-20T10:00:00-08:00",
    "timeZone": "America/Los_Angeles"
  },
  "end": {
    "dateTime": "2026-02-20T11:00:00-08:00",
    "timeZone": "America/Los_Angeles"
  },
  "iCalUID": "abc123@google.com",
  "sequence": 0,
  "reminders": {
    "useDefault": false,
    "overrides": [
      { "method": "email", "minutes": 15 },
      { "method": "popup", "minutes": 10 }
    ]
  }
}
```

## Error Handling

The function throws specific error types for different failure scenarios:

| Error Type | HTTP Status | Cause |
|------------|-------------|-------|
| `GoogleAuthError` | 401 | Access token expired or invalid |
| `GooglePermissionError` | 403 | Insufficient permissions (missing calendar.events scope) |
| `GoogleCalendarAPIError` | Other | General API error with status code and response details |

## Security Notes

- **Never commit your Google access token** - always use environment variables
- Access tokens expire after 1 hour; implement token refresh for production use
- Use the minimum required OAuth scope (`https://www.googleapis.com/auth/calendar`)
- Consider using service accounts for server-to-server authentication
- Store the calendar ID securely if using a shared calendar

## Extending This Run Job

You can extend this function to support additional Google Calendar features:

### Adding Attendees

Add an `attendees` array to the payload:

```xs
var $payload {
  value = {
    summary: $input.summary,
    description: $input.description,
    start: { dateTime: $input.start_time, timeZone: $input.timezone },
    end: { dateTime: $input.end_time, timeZone: $input.timezone },
    attendees: [
      { email: "attendee1@example.com" },
      { email: "attendee2@example.com" }
    ]
  }
}
```

### Adding a Google Meet Link

Add `conferenceData` to create a Google Meet link:

```xs
var $payload {
  value = {
    summary: $input.summary,
    start: { dateTime: $input.start_time, timeZone: $input.timezone },
    end: { dateTime: $input.end_time, timeZone: $input.timezone },
    conferenceData: {
      createRequest: {
        requestId: "sample123",
        conferenceSolutionKey: { type: "hangoutsMeet" }
      }
    }
  }
}
```

Note: When using conferenceData, add `conferenceDataVersion=1` as a query parameter to the API URL.

## Additional Resources

- [Google Calendar API Documentation](https://developers.google.com/calendar/api/v3/reference/events/insert)
- [Google OAuth 2.0 Documentation](https://developers.google.com/identity/protocols/oauth2)
- [Google Calendar API Scopes](https://developers.google.com/identity/protocols/oauth2/scopes#calendar)
- [XanoScript Documentation](https://docs.xano.com)
