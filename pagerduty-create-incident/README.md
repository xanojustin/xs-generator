# PagerDuty Create Incident - Xano Run Job

This Xano Run Job creates an incident in PagerDuty using the [Events API v2](https://developer.pagerduty.com/docs/events-api-v2/overview/) and logs the result to a database table.

## What It Does

1. Accepts incident details (title, service key, urgency, body)
2. Creates an incident via PagerDuty's Events API v2
3. Logs the created incident (or failure) to the `incident_log` table
4. Returns the deduplication key, status, message, and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `PAGERDUTY_API_KEY` | Your PagerDuty API key for authentication (can be a read-only key for Events API) |

**Note:** The Events API v2 uses the service integration key (routing key) which is passed as input, not as an environment variable. You can generate an integration key from your PagerDuty service's integration settings.

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "PagerDuty Create Incident"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "PagerDuty Create Incident" {
  main = {
    name: "create_pagerduty_incident"
    input: {
      title: "Database connection timeout"
      service_key: "your-routing-key-here"
      urgency: "high"
      body: "Primary database is not responding to health checks."
    }
  }
  env = ["PAGERDUTY_API_KEY"]
}
```

### Function Inputs

The `create_pagerduty_incident` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `title` | text | Yes | - | Incident title/summary (what appears in PagerDuty) |
| `service_key` | text | Yes | - | PagerDuty service integration key (routing key) |
| `urgency` | text | No | `"high"` | Incident urgency level: `"high"` or `"low"` |
| `body` | text | No | `""` | Additional incident details shown in custom details |

### Getting Your Service Integration Key

1. Log into PagerDuty
2. Go to **Services** → Select your service
3. Click **Integrations** tab
4. Click **Add Integration** or use an existing one
5. Copy the **Integration Key** (this is your `service_key`)

### Response (Success)

```json
{
  "success": true,
  "dedup_key": "abc123def456",
  "status": "success",
  "message": "Event processed",
  "log_id": 1
}
```

### Response (Error)

If the PagerDuty API returns an error:

```json
{
  "name": "PagerDutyError",
  "value": "PagerDuty API error: Event object is invalid"
}
```

Common errors:
- `Invalid routing key` - The service_key is incorrect or the service doesn't exist
- `Event object is invalid` - Required fields are missing or malformed
- Rate limiting - Too many requests in a short time period

## Files

- `run.xs` - Run job configuration
- `function/create_pagerduty_incident.xs` - Incident creation logic
- `table/incident_log.xs` - Database table for logging incidents

## Notes

- The PagerDuty Events API v2 returns a 202 status code on successful incident creation
- All incidents (successful and failed) are logged to `incident_log`
- The `dedup_key` can be used to acknowledge, resolve, or update the incident later
- Use `high` urgency for critical production issues, `low` for warnings
- Consider setting up different service keys for different environments (prod, staging, dev)

## API Reference

- [PagerDuty Events API v2 Documentation](https://developer.pagerduty.com/docs/events-api-v2/overview/)
- [Trigger Events](https://developer.pagerduty.com/docs/events-api-v2/trigger-events/)
