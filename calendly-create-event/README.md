# Calendly Create One-Off Event Run Job

This XanoScript run job creates a Calendly one-off event type (single-use scheduling link) via the Calendly API.

## What It Does

This run job creates a single-use scheduling link that expires after someone books a time. It's perfect for:

- Sales calls with specific prospects
- Interview scheduling
- One-time meetings that shouldn't be reusable
- Personalized scheduling links

The job handles:

- Creating a one-off event type with custom name and duration
- Setting the meeting location (Zoom, Google Meet, Teams, phone, or custom)
- Optional pre-filling of guest information
- Returning a unique booking URL that expires after use

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `CALENDLY_API_KEY` | Your Calendly personal access token (from https://calendly.com/integrations/api_webhooks) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | text | Yes | Name of the event/meeting (e.g., "Product Demo") |
| `duration` | int | Yes | Duration in minutes (1-300) |
| `timezone` | text | No | Timezone for the event (default: `America/Los_Angeles`) |
| `location_type` | text | No | Meeting location type: `zoom`, `google_meet`, `microsoft_teams`, `phone`, `ask_invitee`, or `custom` (default: `zoom`) |
| `custom_location` | text | No | Custom location URL or address (required if `location_type` is `custom`) |
| `guest_email` | text | No | Pre-fill guest email in the booking form (optional) |
| `guest_name` | text | No | Pre-fill guest name in the booking form (optional) |

### Response

```json
{
  "success": true,
  "booking_url": "https://calendly.com/d/abc123/product-demo-meeting?email=guest@example.com",
  "event_type_id": "dabc1234-5678-90ab-cdef-example11111",
  "expires_at": "2025-02-21T23:59:59.000Z",
  "host_email": "your@email.com",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "booking_url": null,
  "event_type_id": null,
  "expires_at": null,
  "host_email": null,
  "error": "Duration must be between 1 and 300 minutes"
}
```

## File Structure

```
calendly-create-event/
├── run.xs                                         # Run job definition
├── function/
│   └── create_one_off_event_type.xs    # Function to create one-off event
├── README.md                                      # This file
└── FEEDBACK.md                                    # MCP feedback
```

## Calendly API Reference

- [One-Off Event Types API](https://developer.calendly.com/api-docs/3f1259086761d-create-one-off-event-type)
- [Calendly API Overview](https://developer.calendly.com/)

## Getting Your API Key

1. Go to https://calendly.com/integrations/api_webhooks
2. Click "Generate New Token"
3. Copy the personal access token
4. Set it as the `CALENDLY_API_KEY` environment variable

## Location Types

| Type | Description |
|------|-------------|
| `zoom` | Automatically generates a Zoom meeting |
| `google_meet` | Automatically generates a Google Meet link |
| `microsoft_teams` | Automatically generates a Teams meeting |
| `phone` | You call the invitee |
| `ask_invitee` | Ask invitee for location |
| `custom` | Use a custom location (requires `custom_location` parameter) |

## Security Notes

- Never commit your `CALENDLY_API_KEY` to version control
- The API key provides access to your Calendly account - keep it secure
- One-off event types expire after someone books, or after 30 days if unused
