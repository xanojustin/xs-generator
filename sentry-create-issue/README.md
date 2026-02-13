# Sentry Create Issue

This Xano Run Job creates issues/events in Sentry for error tracking and monitoring.

## Overview

This integration allows you to send errors, warnings, and messages from your Xano backend directly to Sentry. It's useful for:

- Tracking application errors and exceptions
- Monitoring warnings and informational events
- Debugging issues across different environments
- Getting alerts when things go wrong

## Required Environment Variables

Configure these environment variables in your Xano instance:

| Variable | Description | Example |
|----------|-------------|---------|
| `sentry_dsn_public_key` | Your Sentry DSN public key | `abc123def456ghi789` |
| `sentry_store_url` | Sentry store endpoint URL | `https://sentry.io/api/12345/store/` |

### Getting Your Sentry Credentials

1. Log into your Sentry account at https://sentry.io
2. Go to **Settings** → **Projects** → Select your project
3. Click **Client Keys (DSN)** under SDK Setup
4. Copy your DSN - it looks like: `https://abc123@sentry.io/12345`
5. Extract the public key (the part between `https://` and `@`)
6. The store URL is: `https://sentry.io/api/{project_id}/store/` where project_id is the number after the last `/`

## Run Job Configuration

The `run.xs` file defines the job entry point:

```xs
run.job "Sentry Create Issue" {
  description = "Create a Sentry issue/event to track errors or messages"
  
  main = {
    name: "sentry_create_issue"
    input: {
      message: "An error occurred in the application"
      level: "error"
      environment: "production"
      platform: "javascript"
    }
  }
  
  env = ["sentry_dsn_public_key", "sentry_store_url"]
}
```

## Function: sentry_create_issue

Creates a Sentry event with the following parameters:

### Input Parameters

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `message` | text | Yes | - | The main error message or event title |
| `level` | text | No | `error` | Event level: `fatal`, `error`, `warning`, `info`, `debug` |
| `environment` | text | No | `production` | Environment: `production`, `staging`, `development` |
| `release` | text | No | - | Release version (e.g., `1.0.0`) |
| `platform` | text | No | `javascript` | Platform: `javascript`, `python`, `node`, `php`, `go`, `ruby` |
| `culprit` | text | No | - | Function/method where error occurred |
| `extra` | json | No | - | Additional context data |
| `tags` | json | No | - | Custom tags for filtering |
| `user` | json | No | - | User context (id, email, username, ip_address) |
| `exception` | json | No | - | Exception details with type, value, stacktrace |

### Response

```json
{
  "success": true,
  "event_id": "a1b2c3d4e5f6g7h8i9j0",
  "status_code": 200,
  "message": "Event created successfully in Sentry"
}
```

## Usage Examples

### Basic Error

```json
{
  "message": "Database connection failed"
}
```

### Warning with Context

```json
{
  "message": "API rate limit approaching",
  "level": "warning",
  "extra": {
    "requests_remaining": 10,
    "reset_time": "2025-02-13T10:00:00Z"
  }
}
```

### Error with Full Context

```json
{
  "message": "User authentication failed",
  "level": "error",
  "environment": "staging",
  "release": "2.1.0-beta",
  "platform": "php",
  "culprit": "AuthController::login()",
  "extra": {
    "login_attempts": 3,
    "last_attempt": "2025-02-13T09:45:00Z"
  },
  "tags": {
    "feature": "authentication",
    "region": "us-west"
  },
  "user": {
    "id": "123",
    "email": "user@example.com"
  },
  "exception": {
    "type": "PaymentError",
    "value": "Insufficient funds",
    "stacktrace": {
      "frames": [
        {"function": "processPayment", "filename": "payments.js", "lineno": 42}
      ]
    }
  }
}
```

## Sentry Event Levels

| Level | Use Case |
|-------|----------|
| `fatal` | Application crashes, unrecoverable errors |
| `error` | General errors that need attention |
| `warning` | Suspicious conditions, recoverable issues |
| `info` | General informational events |
| `debug` | Detailed debugging information |

## File Structure

```
sentry-create-issue/
├── functions/
│   └── sentry_create_issue.xs
├── run.xs
└── README.md
```

## License

MIT

## Support

For issues or questions about this Xano Run Job, please refer to:
- [Xano Documentation](https://docs.xano.com)
- [Sentry Documentation](https://docs.sentry.io)
