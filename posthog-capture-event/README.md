# PostHog Capture Event Run Job

This XanoScript run job captures events to PostHog, a popular product analytics platform.

## What It Does

This run job sends event data to PostHog's capture API, enabling you to:

- Track user actions (page views, clicks, sign-ups, purchases)
- Analyze user behavior and product usage
- Build funnels and retention reports
- Create custom dashboards and insights

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `POSTHOG_API_KEY` | Your PostHog project API key (starts with `phc_`) |
| `POSTHOG_HOST` | PostHog instance URL (default: `https://us.posthog.com`) |

### PostHog Host Options

- `https://us.posthog.com` - US Cloud (default)
- `https://eu.posthog.com` - EU Cloud
- `https://your-domain.com` - Self-hosted instance

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event` | text | Yes | Event name (e.g., `page_view`, `user_signed_up`, `purchase_completed`) |
| `distinct_id` | text | Yes | Unique identifier for the user (user ID, email, UUID) |
| `properties` | object | No | Additional event properties as key-value pairs |
| `timestamp` | text | No | ISO 8601 timestamp (defaults to current time) |

### Response

```json
{
  "success": true,
  "event": "page_view",
  "distinct_id": "user_123",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "event": "page_view",
  "distinct_id": "user_123",
  "error": "PostHog API error: HTTP 401"
}
```

## File Structure

```
posthog-capture-event/
├── run.xs                    # Run job definition
├── function/
│   └── capture_event.xs      # Function to capture events
└── README.md                 # This file
```

## PostHog API Reference

- [Capture API](https://posthog.com/docs/api/capture)
- [Event Tracking Guide](https://posthog.com/docs/product-analytics/capture-events)
- [Self-Hosted Setup](https://posthog.com/docs/self-host)

## Example Usage

### Basic Event
```
event: "page_view"
distinct_id: "user_123"
```

### Event with Properties
```
event: "purchase_completed"
distinct_id: "user_456"
properties: {
  product_id: "prod_789",
  price: 99.99,
  currency: "USD"
}
```

## Security Notes

- Never commit your `POSTHOG_API_KEY` to version control
- Use environment-specific projects (dev/staging/prod)
- Consider hashing or anonymizing `distinct_id` for privacy compliance
- The API key only needs write access for event capture

## Troubleshooting

- **401 Unauthorized**: Check that your API key is correct and active
- **400 Bad Request**: Verify event name and distinct_id are provided
- **Connection errors**: Ensure POSTHOG_HOST is set correctly for your instance