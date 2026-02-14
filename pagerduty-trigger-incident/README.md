# PagerDuty Trigger Incident - Xano Run Job

This Xano Run Job triggers a PagerDuty incident via the PagerDuty Events API v2. It's useful for alerting on critical system events, failures, or other situations requiring immediate attention.

## What It Does

- Triggers a PagerDuty incident with configurable severity, summary, and metadata
- Supports all PagerDuty severity levels: `critical`, `error`, `warning`, `info`
- Returns the deduplication key for incident tracking
- Handles API errors gracefully with detailed response information

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `pagerduty_integration_key` | Your PagerDuty Events API v2 integration key | Yes |

### Getting Your Integration Key

1. In PagerDuty, go to **Services** → **Service Directory**
2. Select or create a service
3. Go to the **Integrations** tab
4. Add an integration of type **Events API v2**
5. Copy the **Integration Key** (starts with `r+` or similar)

## How to Use

### Basic Usage

The run job will trigger an incident with default values:
- Summary: "Critical system alert from Xano Run Job"
- Severity: "critical"
- Source: "Xano Run Job"

### Customizing Input Parameters

Edit `run.xs` to customize the incident:

```xs
run.job "PagerDuty Trigger Incident" {
  main = {
    name: "trigger_incident"
    input: {
      summary: "Database connection failed - Production"
      severity: "error"
      source: "production-api"
      component: "database"
      group: "infrastructure"
    }
  }
  env = ["pagerduty_integration_key"]
}
```

### Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `summary` | text | "Critical system alert from Xano Run Job" | Short description of the incident |
| `severity` | text | "critical" | Severity level: `critical`, `error`, `warning`, `info` |
| `source` | text | "Xano Run Job" | Source of the incident |
| `component` | text | - | Component affected (optional) |
| `group` | text | - | Logical grouping (optional) |
| `class` | text | - | Class/type of incident (optional) |

### Response

On success:
```json
{
  "success": true,
  "message": "Incident triggered successfully",
  "dedup_key": "abc123def456",
  "status": "success"
}
```

On failure:
```json
{
  "success": false,
  "message": "Failed to trigger incident",
  "status": 400,
  "error": "{...error details...}"
}
```

## File Structure

```
pagerduty-trigger-incident/
├── run.xs                      # Run job configuration
├── function/
│   └── trigger_incident.xs     # Main logic
└── README.md                   # This file
```

## PagerDuty API Reference

- [PagerDuty Events API v2 Documentation](https://developer.pagerduty.com/docs/events-api-v2-overview)
- The integration uses the `/v2/enqueue` endpoint

## Use Cases

- Alert on failed cron jobs or scheduled tasks
- Notify on critical system failures
- Integrate with monitoring systems
- Trigger on-call rotations for urgent issues

## Security Notes

- Never commit your PagerDuty integration key to version control
- Use environment variables for all sensitive credentials
- Consider using separate integration keys for different environments (dev/staging/prod)
