# Mixpanel Track Event Run Job

This XanoScript run job tracks analytics events to Mixpanel, a product analytics platform.

## What It Does

This run job sends event data to Mixpanel's tracking API. It handles:

- Tracking custom events with a name and timestamp
- Associating events with unique users via distinct_id
- Adding custom properties to events (JSON object)
- IP-based geolocation support
- Optional custom timestamp for backfilling events

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MIXPANEL_PROJECT_TOKEN` | Your Mixpanel project token (found in Project Settings) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event` | text | Yes | Event name to track (e.g., "User Signup", "Purchase Completed") |
| `distinct_id` | text | No | Unique identifier for the user (for tracking user journeys) |
| `properties` | text | No | JSON string with custom event properties (e.g., `{"plan": "pro", "amount": 99}`) |
| `ip` | text | No | User's IP address (for geolocation tracking) |
| `time` | text | No | Unix timestamp for the event (defaults to current time) |

### Response

**Success:**
```json
{
  "success": true,
  "event": "User Action",
  "status_code": 200,
  "error": null
}
```

**Error:**
```json
{
  "success": false,
  "event": "User Action",
  "status_code": 400,
  "error": "Mixpanel returned error: 0"
}
```

## File Structure

```
mixpanel-track-event/
├── run.xs                    # Run job definition
├── function/
│   └── track_event.xs        # Function to track events
├── README.md                 # This file
└── FEEDBACK.md              # Development feedback
```

## Mixpanel API Reference

- [Mixpanel HTTP API](https://developer.mixpanel.com/reference/track-event)
- [Project Token](https://developer.mixpanel.com/reference/project-token)

## Example Usage

### Track a Purchase Event

```xs
// In run.xs or via API call
input: {
  event: "Purchase Completed"
  distinct_id: "user_98765"
  properties: "{\"product_id\": \"sku_123\", \"amount\": 49.99, \"currency\": \"USD\"}"
}
```

### Track a Page View

```xs
input: {
  event: "Page Viewed"
  distinct_id: "user_98765"
  properties: "{\"page\": \"/pricing\", \"referrer\": \"google\"}"
  ip: "203.0.113.42"
}
```

## Security Notes

- Never commit your `MIXPANEL_PROJECT_TOKEN` to version control
- The project token is different from your API secret - it's meant for client-side tracking
- For server-to-server tracking, consider using the API secret with the import endpoint for more security

## Testing

You can verify events are being tracked by:
1. Checking the Mixpanel Live View in your project dashboard
2. Looking for the event name in the Events section
3. Verifying user profiles are updated (if using distinct_id)
