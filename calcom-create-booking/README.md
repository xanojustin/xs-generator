# Cal.com Create Booking - Xano Run Job

This Xano Run Job creates a new booking via the Cal.com API v2. Cal.com is an open-source scheduling infrastructure that allows you to schedule meetings, appointments, and events.

## What This Run Job Does

Creates a booking/appointment in Cal.com by calling their API v2 bookings endpoint. This is useful for:

- Scheduling customer appointments
- Booking meetings with clients
- Creating event registrations
- Integrating scheduling into your application workflow

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `CALCOM_API_KEY` | Your Cal.com API key | `cal_live_abc123xyz...` |
| `CALCOM_BASE_URL` | Cal.com API base URL (optional, defaults to v2) | `https://api.cal.com/v2` |

### Getting Your Cal.com API Key

1. Log in to your Cal.com account
2. Go to Settings → Developer → API Keys
3. Generate a new API key
4. Copy the key and set it as `CALCOM_API_KEY`

## How to Use

### Running the Job

```bash
xano run --job "Cal.com Create Booking"
```

### Input Parameters

The run job accepts the following input parameters:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event_type_id` | integer | Yes | The ID of the event type to book |
| `start_time` | string | Yes | ISO 8601 timestamp for the booking start |
| `attendee.name` | string | Yes | Name of the attendee |
| `attendee.email` | string | Yes | Email of the attendee |
| `attendee.time_zone` | string | Yes | IANA time zone (e.g., "America/Los_Angeles") |
| `title` | string | No | Custom title for the booking |
| `description` | string | No | Description/notes for the booking |
| `location` | string | No | Location of the meeting |

### Example Input

```json
{
  "event_type_id": 12345,
  "start_time": "2026-02-20T14:00:00Z",
  "attendee": {
    "name": "John Doe",
    "email": "john@example.com",
    "time_zone": "America/Los_Angeles"
  },
  "title": "Product Demo",
  "description": "Discussion about new features",
  "location": "Zoom"
}
```

### Example Response

```json
{
  "success": true,
  "booking": {
    "id": "abc123",
    "uid": "booking-uid-xyz",
    "title": "Product Demo",
    "description": "Discussion about new features",
    "start": "2026-02-20T14:00:00Z",
    "end": "2026-02-20T15:00:00Z",
    "attendees": [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "time_zone": "America/Los_Angeles"
      }
    ],
    "status": "accepted"
  }
}
```

## File Structure

```
~/xs/calcom-create-booking/
├── run.xs                      # Run job configuration
├── function/
│   └── create_booking.xs       # Booking creation function
└── README.md                   # This file
```

## Error Handling

The run job handles the following error cases:

- **Input validation errors**: Missing or invalid required fields
- **Configuration errors**: Missing `CALCOM_API_KEY` environment variable
- **API errors**: Non-2xx responses from Cal.com API with detailed error messages

## API Reference

- **Cal.com API v2 Documentation**: https://cal.com/docs/api-reference/v2
- **Bookings Endpoint**: POST `/v2/bookings`

## Customization

You can modify `function/create_booking.xs` to:

- Add additional booking metadata
- Handle recurring bookings
- Add webhook callbacks
- Integrate with your notification system
