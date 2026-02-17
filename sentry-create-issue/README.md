# Sentry Create Issue - Xano Run Job

This Xano Run Job creates an error event/issue in Sentry for error tracking and monitoring. It demonstrates how to integrate with Sentry's event ingestion API from Xano.

## What This Run Job Does

The `Sentry Create Issue` run job sends error events to Sentry by:
1. Accepting error details (message, level, environment, platform)
2. Parsing the Sentry DSN to extract authentication credentials
3. Making an authenticated request to Sentry's `/api/{project_id}/store/` endpoint
4. Returning the created event ID and success status

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `sentry_dsn` | Your Sentry project DSN | `https://abc123@o123456.ingest.sentry.io/7890123` |

### Getting Your Sentry DSN

1. Log in to your [Sentry Dashboard](https://sentry.io)
2. Select your project
3. Go to Settings → Client Keys (DSN)
4. Copy your **DSN** (starts with `https://`)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Sentry Create Issue"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Sentry Create Issue"
}
```

### Customizing the Event

Edit the `input` block in `run.xs`:

```xs
run.job "Sentry Create Issue" {
  main = {
    name: "sentry_create_issue"
    input: {
      message: "Database connection failed"
      level: "fatal"
      environment: "production"
      platform: "python"
      tags: {
        component: "database"
        version: "2.0.0"
      }
      extra: {
        connection_string: "postgresql://..."
        retry_count: 3
      }
    }
  }
  env = ["sentry_dsn"]
}
```

### Input Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `message` | text | Error message or issue title | Required |
| `level` | text | Severity: fatal, error, warning, info, debug | error |
| `environment` | text | Environment: production, staging, development | production |
| `platform` | text | Platform: javascript, python, node, php, etc. | javascript |
| `tags` | object | Key-value pairs for filtering/grouping | Optional |
| `extra` | object | Additional context data | Optional |

## File Structure

```
sentry-create-issue/
├── run.xs                        # Run job configuration
├── function/
│   └── sentry_create_issue.xs    # Function that sends event to Sentry
├── README.md                     # This file
└── FEEDBACK.md                   # Development feedback
```

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "event_id": "a1b2c3d4e5f6...",
  "sentry_response": {
    "id": "a1b2c3d4e5f6..."
  }
}
```

## Error Handling

The function throws a `SentryAPIError` if:
- The Sentry API returns a non-2xx status code
- The request times out
- Authentication fails (invalid DSN)

## Security Notes

- **Never commit your Sentry DSN** - always use environment variables
- The DSN contains your public key but should still be kept private
- Create separate Sentry projects for different environments
- Use Sentry's rate limiting to prevent abuse

## Additional Resources

- [Sentry API Documentation](https://docs.sentry.io/api/)
- [Sentry Event Ingestion](https://docs.sentry.io/product/security/token-auth/)
- [XanoScript Documentation](https://docs.xano.com)
