# Segment Track Event Run Job

This XanoScript run job tracks analytics events using the Segment API.

## What It Does

This run job sends track events to Segment's analytics platform. It handles:

- Tracking user actions/events with custom properties
- Supporting both identified users (user_id) and anonymous users (anonymous_id)
- Adding contextual data (IP, user agent, etc.)
- Setting custom timestamps for historical events
- Controlling destination integrations

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SEGMENT_WRITE_KEY` | Your Segment write key (found in your Segment workspace settings) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event` | text | Yes | Name of the event to track (e.g., "User Signed Up", "Order Completed") |
| `user_id` | text | Conditional | Unique identifier for the user (required if no anonymous_id) |
| `anonymous_id` | text | Conditional | Anonymous identifier for users without an account (required if no user_id) |
| `properties` | object | No | Event properties/metadata (e.g., `{ "plan": "pro", "revenue": 99.99 }`) |
| `context` | object | No | Context about the event (e.g., `{ "ip": "192.168.1.1", "user_agent": "..." }`) |
| `timestamp` | text | No | ISO 8601 timestamp (e.g., `2026-02-14T10:30:00Z`) |
| `integrations` | object | No | Enable/disable destinations (e.g., `{ "Google Analytics": false }`) |

### Response

```json
{
  "success": true,
  "message": "Event tracked successfully",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "message": null,
  "error": "Segment API error: HTTP 401 - {\"message\":\"unauthorized\"}"
}
```

## File Structure

```
segment-track-event/
├── run.xs                    # Run job definition
├── function/
│   └── track_event.xs        # Function to track events
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Segment API Reference

- [Track API Documentation](https://segment.com/docs/connections/sources/catalog/libraries/server/http-api/#track)
- [Segment HTTP API](https://segment.com/docs/connections/sources/catalog/libraries/server/http-api/)

## Example Usage

### Track a user signup
```json
{
  "event": "User Signed Up",
  "user_id": "user_12345",
  "properties": {
    "plan": "pro",
    "source": "landing_page"
  }
}
```

### Track an anonymous user action
```json
{
  "event": "Product Viewed",
  "anonymous_id": "anon_67890",
  "properties": {
    "product_id": "prod_123",
    "category": "electronics"
  }
}
```

### Track with context
```json
{
  "event": "Purchase Completed",
  "user_id": "user_12345",
  "properties": {
    "order_id": "order_456",
    "revenue": 99.99
  },
  "context": {
    "ip": "192.168.1.1",
    "user_agent": "Mozilla/5.0..."
  }
}
```

## Security Notes

- Never commit your `SEGMENT_WRITE_KEY` to version control
- Use a write key with limited permissions in development
- Segment write keys start with your source ID followed by the actual key
- The API uses HTTP Basic Auth with the write key as the username and empty password