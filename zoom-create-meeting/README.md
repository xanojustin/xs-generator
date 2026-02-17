# Zoom Create Meeting - Xano Run Job

This Xano Run Job creates a scheduled Zoom meeting using Zoom's Server-to-Server OAuth API.

## What It Does

Creates a Zoom meeting with customizable options including:
- Meeting topic and agenda
- Scheduled start time (ISO 8601 format)
- Duration in minutes
- Timezone configuration
- Optional meeting password
- Waiting room settings
- Join-before-host control

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `ZOOM_ACCOUNT_ID` | Your Zoom account ID | Zoom Developer Portal → Server-to-Server OAuth app → App Credentials |
| `ZOOM_CLIENT_ID` | OAuth app client ID | Zoom Developer Portal → Server-to-Server OAuth app → App Credentials |
| `ZOOM_CLIENT_SECRET` | OAuth app client secret | Zoom Developer Portal → Server-to-Server OAuth app → App Credentials |

## Setup Instructions

1. **Create a Zoom Server-to-Server OAuth App:**
   - Go to [Zoom Developer Portal](https://marketplace.zoom.us/develop/create)
   - Click "Server-to-Server OAuth"
   - Name your app (e.g., "Xano Integration")
   - Enable the `meeting:write:meeting` scope
   - Activate the app

2. **Copy Credentials:**
   - Note down Account ID, Client ID, and Client Secret
   - Store them as environment variables in Xano

3. **Run the Job:**
   ```bash
   xano run execute --job="Create Zoom Meeting"
   ```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `topic` | text | Yes | - | Meeting title |
| `agenda` | text | No | "" | Meeting description |
| `start_time` | text | Yes | - | ISO 8601 datetime (e.g., "2025-02-17T10:00:00") |
| `duration` | int | No | 60 | Meeting duration in minutes |
| `timezone` | text | No | "America/Los_Angeles" | IANA timezone identifier |
| `password` | text | No | "" | Meeting password (optional) |
| `waiting_room` | bool | No | true | Enable waiting room |
| `join_before_host` | bool | No | false | Allow joining before host |

## Response

Returns an object with meeting details:

```json
{
  "id": "123456789",
  "topic": "Team Standup Meeting",
  "start_time": "2025-02-17T10:00:00",
  "duration": 30,
  "timezone": "America/Los_Angeles",
  "join_url": "https://zoom.us/j/123456789",
  "start_url": "https://zoom.us/s/123456789",
  "password": "abc123",
  "meeting_number": 123456789
}
```

## File Structure

```
zoom-create-meeting/
├── README.md                      # This file
├── FEEDBACK.md                    # Development feedback for MCP improvement
├── function/
│   └── create_zoom_meeting.xs     # Main function implementation
└── run/
    └── run.xs                     # Run job configuration
```

## Error Handling

The function validates:
- All required environment variables are present
- OAuth token request succeeds
- Meeting creation API returns success (HTTP 201)

Errors are thrown with descriptive messages for debugging.

## API Reference

- [Zoom Server-to-Server OAuth](https://developers.zoom.us/docs/internal-apps/s2s-oauth/)
- [Zoom Meetings API](https://developers.zoom.us/docs/api/rest/reference/zoom-api/methods/#operation/meetingCreate)
