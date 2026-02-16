# Amplitude Track Event Run Job

This XanoScript run job sends event tracking data to Amplitude's analytics API.

## What It Does

This run job sends an analytics event to Amplitude using their HTTP API. It handles:

- Sending user actions/events to Amplitude
- Supporting user identification and device tracking
- Including event properties and user properties
- Handling API responses and errors
- Supporting revenue tracking for e-commerce events

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `AMPLITUDE_API_KEY` | Your Amplitude API key (found in Amplitude Settings > Projects) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event_type` | text | Yes | The name of the event (e.g., `purchase`, `signup`, `page_view`) |
| `user_id` | text | Yes* | Unique identifier for the user (*required if device_id not provided) |
| `device_id` | text | Yes* | Device identifier (*required if user_id not provided) |
| `event_properties` | object | No | Object containing event-specific properties |
| `user_properties` | object | No | Object containing user attributes to update |
| `time` | integer | No | Event timestamp in milliseconds since epoch (defaults to now) |
| `platform` | text | No | Platform (e.g., `iOS`, `Android`, `Web`) |
| `revenue` | float | No | Revenue amount for purchase events |
| `product_id` | text | No | Product identifier for purchase events |

### Response

```json
{
  "success": true,
  "code": 200,
  "events_ingested": 1,
  "payload_size_bytes": 256,
  "server_upload_time": 1643723400000,
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "code": 400,
  "error": "Invalid API key or malformed request",
  "events_ingested": 0
}
```

## File Structure

```
amplitude-track-event/
├── run.xs                    # Run job definition
├── function/
│   └── track_event.xs        # Function to send event to Amplitude
└── README.md                 # This file
```

## Amplitude API Reference

- [Amplitude HTTP API](https://developers.amplitude.com/docs/http-api-v2)
- [Event Properties](https://help.amplitude.com/hc/en-us/articles/115002380567-User-Properties-and-Event-Properties)
- [Best Practices](https://help.amplitude.com/hc/en-us/articles/360044834531)

## Testing

Test events appear in Amplitude's User Lookup within a few minutes. Use Amplitude's Debug mode to verify events are being received.

## Security Notes

- Never commit your `AMPLITUDE_API_KEY` to version control
- Use Amplitude's test project API key during development
- The API key should be restricted to specific domains in production

## Common Event Types

- `signup` - User registration
- `login` - User login
- `purchase` - Completed transaction
- `page_view` - Page/app screen viewed
- `feature_used` - User interacted with a feature
