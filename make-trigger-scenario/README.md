# Make.com Trigger Scenario Run Job

This Xano Run Job triggers a Make.com (formerly Integromat) scenario via webhook.

## What It Does

Sends a POST request to a Make.com webhook URL with custom payload data to trigger automation scenarios. Useful for:

- Syncing Xano data with other services via Make
- Triggering complex multi-step automations
- Connecting Xano to 1000+ apps via Make integrations
- Scheduling regular data exports or imports

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `make_webhook_url` | Your Make scenario webhook URL | `https://hook.make.com/abc123xyz` |

### Getting Your Webhook URL

1. In Make.com, create or edit a scenario
2. Add a "Webhooks" module as the trigger
3. Select "Custom webhook"
4. Copy the webhook URL provided
5. Set this as the `make_webhook_url` environment variable in Xano

## How to Use

### Run the Job

The job will execute automatically with the configured inputs, or you can customize:

```bash
# Using Xano CLI
xano run execute --job "Trigger Make Scenario"
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `scenario_name` | text | Yes | Identifier for the scenario being triggered |
| `payload` | object | Yes | Custom data to send to Make |

### Example Payload Structure

```json
{
  "scenario_name": "xano-data-sync",
  "payload": {
    "event": "user_signup",
    "user_id": 12345,
    "email": "user@example.com",
    "plan": "premium",
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

## Response

```json
{
  "status": "success",
  "message": "Scenario triggered successfully",
  "scenario_name": "xano-data-sync",
  "http_status": 200,
  "response_body": { ... }
}
```

## Error Handling

The job handles common error cases:

- **Missing webhook URL**: Returns error if `make_webhook_url` env var is not set
- **Rate limiting**: Detects 429 status and reports rate limit exceeded
- **API errors**: Returns HTTP status and error details

## File Structure

```
make-trigger-scenario/
├── run.xs                          # Run job definition
├── function/
│   └── trigger_make_scenario.xs    # Webhook trigger function
└── README.md                       # This file
```

## Make.com Scenario Setup Tips

1. **Data Mapping**: In your Make scenario, use the webhook data to map fields to other apps
2. **Error Handling**: Add error handling modules in Make for robustness
3. **Scheduling**: Combine with Xano scheduled tasks for recurring automations
4. **Batch Processing**: Send arrays of records for bulk operations

## Security Notes

- Keep your webhook URL secret - it can trigger your scenario
- Use environment variables for the webhook URL, never hardcode it
- Consider adding an API key or signature validation in Make for extra security
