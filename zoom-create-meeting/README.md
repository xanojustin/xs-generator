# Zoom Create Meeting Run Job

This Xano run job creates a new Zoom meeting via the Zoom API.

## What It Does

Creates a Zoom meeting with configurable options including:
- Meeting topic/title
- Start time (ISO 8601 format)
- Duration (in minutes)
- Timezone
- Meeting type (instant or scheduled)
- Password protection (optional)
- Waiting room settings
- Auto-recording options

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `ZOOM_ACCOUNT_ID` | Your Zoom Server-to-Server OAuth Account ID | `abc123def456` |
| `ZOOM_CLIENT_ID` | Your Zoom Server-to-Server OAuth Client ID | `XYZ123ABC` |
| `ZOOM_CLIENT_SECRET` | Your Zoom Server-to-Server OAuth Client Secret | `secret_key_here` |

## How to Get Zoom Credentials

1. Go to [Zoom Marketplace](https://marketplace.zoom.us/)
2. Click **Develop** → **Build Server-to-Server App**
3. Create a new app and enable the following scopes:
   - `meeting:write:admin` - Create meetings
   - `meeting:read:admin` - Read meeting details
4. Copy the **Account ID**, **Client ID**, and **Client Secret**

## API Endpoint

### POST `/zoom/create-meeting`

Creates a new Zoom meeting.

#### Request Body

```json
{
  "topic": "Team Weekly Standup",
  "start_time": "2025-02-15T14:00:00Z",
  "duration": 60,
  "timezone": "America/Los_Angeles",
  "agenda": "Weekly team sync to discuss progress",
  "password": "standup123",
  "settings": {
    "waiting_room": true,
    "auto_recording": "cloud"
  }
}
```

#### Response

```json
{
  "success": true,
  "meeting": {
    "id": "1234567890",
    "topic": "Team Weekly Standup",
    "start_time": "2025-02-15T14:00:00Z",
    "duration": 60,
    "timezone": "America/Los_Angeles",
    "join_url": "https://zoom.us/j/1234567890?pwd=...",
    "start_url": "https://zoom.us/s/1234567890?pwd=...",
    "password": "standup123",
    "status": "waiting"
  }
}
```

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `topic` | string | Yes | - | Meeting title |
| `start_time` | timestamp | No | now | Meeting start time (ISO 8601) |
| `duration` | int | No | 30 | Meeting duration in minutes |
| `timezone` | string | No | UTC | IANA timezone name |
| `agenda` | string | No | - | Meeting description |
| `password` | string | No | auto-generated | Meeting password (max 10 chars) |
| `waiting_room` | bool | No | true | Enable waiting room |
| `auto_recording` | string | No | "none" | Recording: "none", "local", "cloud" |

## Files Structure

```
zoom-create-meeting/
├── apis/
│   └── zoom/
│       └── create-meeting.xs    # API endpoint definition
├── functions/
│   └── zoom_get_access_token.xs # OAuth token function
└── README.md
```

## Testing

Test locally by sending a POST request:

```bash
curl -X POST https://your-instance.xano.io/api:your-api-group/zoom/create-meeting \
  -H "Content-Type: application/json" \
  -d '{
    "topic": "Test Meeting",
    "duration": 30
  }'
```

## Error Handling

The run job handles common errors:
- Invalid credentials → 401 Unauthorized
- Rate limiting → 429 Too Many Requests
- Invalid parameters → 400 Bad Request

## Rate Limits

Zoom Server-to-Server OAuth apps have a rate limit of **6,000 requests per day**.

## Additional Resources

- [Zoom API Documentation](https://developers.zoom.us/docs/api/)
- [Zoom Meeting API Reference](https://developers.zoom.us/docs/api/rest/reference/zoom-api/methods/#operation/meetingCreate)
- [XanoScript Documentation](https://docs.xano.com)

---

Created by OpenClaw XanoScript Generator
