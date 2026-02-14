# Sentry Send Event Run Job

A Xano Run Job that sends error events and messages to [Sentry](https://sentry.io) - a popular error tracking and performance monitoring platform for developers.

## What This Run Job Does

This run job sends an error event to your Sentry project via the Sentry Envelope API. It supports:

- **Error Levels**: error, warning, info, debug
- **Environment Tracking**: production, staging, development
- **Release Versioning**: Track which release introduced the error
- **User Context**: Associate events with specific users
- **Custom Tags**: Add searchable metadata to events
- **Extra Context**: Attach additional structured data

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `SENTRY_DSN` | Your Sentry DSN (Data Source Name) | `https://abc123@o123456.ingest.sentry.io/7890123` |
| `SENTRY_PROJECT_ID` | Your Sentry project ID | `7890123` |

### Getting Your Sentry DSN

1. Log in to [sentry.io](https://sentry.io)
2. Navigate to your project settings
3. Go to **Client Keys (DSN)**
4. Copy your DSN - it looks like: `https://public_key@o123456.ingest.sentry.io/1234567`

## How to Use

### Basic Usage

Run the job with default settings (sends an error-level event):

```bash
# Run via Xano Job Runner
xano run ~/xs/sentry-send-event
```

### Customizing Input

Edit the `run.xs` file to customize the event:

```xs
run.job "Send Sentry Event" {
  main = {
    name: "send_sentry_event"
    input: {
      message: "User login failed - invalid credentials"
      level: "warning"
      environment: "staging"
      release: "v1.2.3"
      user_id: "user_12345"
      tags: ["feature:auth", "component:login"]
      extra: {
        ip_address: "192.168.1.1"
        user_agent: "Mozilla/5.0..."
      }
    }
  }
  env = ["SENTRY_DSN", "SENTRY_PROJECT_ID"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `message` | text | Yes | - | The error message or event description |
| `level` | text | No | `"error"` | Event severity: `fatal`, `error`, `warning`, `info`, `debug` |
| `environment` | text | No | `"production"` | Environment name (production, staging, development) |
| `release` | text | No | - | Release version for tracking regressions |
| `user_id` | text | No | - | User ID to associate with the event |
| `tags` | text[] | No | - | Array of tags in format `["key:value"]` |
| `extra` | object | No | - | Additional context data (arbitrary JSON object) |

## Output

The function returns an object with the event result:

```json
{
  "success": true,
  "event_id": "550e8400-e29b-41d4-a716-446655440000",
  "status": 200
}
```

Or on failure:

```json
{
  "success": false,
  "error": "Sentry API error: 401",
  "response": { ... }
}
```

## Files Structure

```
sentry-send-event/
├── run.xs                    # Run job configuration
├── function/
│   └── send_sentry_event.xs  # Main function logic
└── README.md                 # This file
```

## Example Use Cases

### Track API Errors

Send detailed error reports when your API endpoints fail:

```xs
input: {
  message: "Database connection timeout"
  level: "error"
  environment: "production"
  tags: ["endpoint:/api/users", "method:GET", "db:primary"]
  extra: {
    query_duration_ms: 30000
    connection_pool_size: 10
  }
}
```

### Monitor Background Jobs

Track job failures and performance:

```xs
input: {
  message: "Email job failed after 3 retries"
  level: "warning"
  tags: ["job:send_email", "queue:default", "retry:3"]
  extra: {
    recipient: "user@example.com"
    template: "welcome"
  }
}
```

### Performance Monitoring

Log performance issues as info/warning events:

```xs
input: {
  message: "Slow query detected: 2.5s"
  level: "warning"
  tags: ["performance", "query:slow"]
  extra: {
    query: "SELECT * FROM large_table..."
    duration_ms: 2500
  }
}
```

## Sentry Resources

- [Sentry Documentation](https://docs.sentry.io/)
- [Sentry Envelope API](https://develop.sentry.dev/sdk/envelopes/)
- [Event Payload Format](https://develop.sentry.dev/sdk/event-payloads/)

## License

MIT
