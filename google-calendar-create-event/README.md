# Google Calendar Create Event

A Xano Run Job that creates events in Google Calendar using the Google Calendar API.

## What It Does

This run job creates a new event in a Google Calendar with:
- Event title and description
- Start and end times (ISO 8601 format with timezone)
- Optional list of attendee email addresses

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `GOOGLE_CALENDAR_API_KEY` | Google OAuth 2.0 access token with Calendar API scope | Yes |
| `GOOGLE_CALENDAR_ID` | Calendar ID to create event in (defaults to "primary" if not set) | No |

## How to Get a Google Calendar API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the Google Calendar API
4. Go to **Credentials** → **Create Credentials** → **OAuth 2.0 Client ID**
5. Download the credentials and get an access token with the scope: `https://www.googleapis.com/auth/calendar`
6. Use the access token as `GOOGLE_CALENDAR_API_KEY`

## Usage

### Run the Job

```bash
xano run
```

Or trigger via Xano Run API with custom inputs.

### Default Inputs

The run job includes default inputs for testing:
- Summary: "Meeting with Team"
- Description: "Weekly sync meeting"
- Start Time: "2026-02-20T10:00:00-08:00"
- End Time: "2026-02-20T11:00:00-08:00"
- Attendees: ["team@example.com"]

### Custom Inputs

You can override inputs when running:

```json
{
  "summary": "Product Review",
  "description": "Q1 product roadmap review",
  "start_time": "2026-03-15T14:00:00-07:00",
  "end_time": "2026-03-15T15:30:00-07:00",
  "attendees": ["alice@example.com", "bob@example.com"]
}
```

## Response

On success, returns:

```json
{
  "success": true,
  "event_id": "abc123eventid",
  "event_link": "https://www.google.com/calendar/event?eid=...",
  "summary": "Product Review",
  "start": { "dateTime": "2026-03-15T14:00:00-07:00" },
  "end": { "dateTime": "2026-03-15T15:30:00-07:00" },
  "created": "2026-02-16T13:45:00.000Z"
}
```

## Files

- `run.xs` - Run job configuration
- `function/create_calendar_event.xs` - Function that creates the calendar event
- `README.md` - This documentation
- `FEEDBACK.md` - MCP/XanoScript development feedback

## API Reference

- [Google Calendar API - Events](https://developers.google.com/calendar/api/v3/reference/events/insert)
