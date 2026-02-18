# New Relic Submit Event - Xano Run Job

This Xano Run Job submits custom events to New Relic's Insights API for monitoring and observability.

## What It Does

This run job sends custom events to New Relic, allowing you to track business metrics, user actions, or any custom data in your New Relic dashboards. It:

1. Validates input parameters (event_type, account_id, and event_data must be present)
2. Constructs the event payload in New Relic's expected format
3. Sends the event to New Relic's Insights Collector API (`POST /v1/accounts/{account_id}/events`)
4. Logs the result to a local `event_log` table (success or failure)
5. Returns detailed submission information on success, or throws an error on failure

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `NEW_RELIC_INSERT_KEY` | Your New Relic Insert API key (found in API Keys section of your account) |

Get your Insert API key from: https://one.newrelic.com/launcher/api-keys-ui.launcher

## How to Use

### Running the Job

```bash
# Via Xano CLI
xano run run.xs --env NEW_RELIC_INSERT_KEY=your_insert_key_here

# Or set the env var first
export NEW_RELIC_INSERT_KEY=your_insert_key_here
xano run run.xs
```

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "New Relic Submit Event" {
  main = {
    name: "submit_event"
    input: {
      event_type: "PurchaseEvent"           // Event type name (appears in NRQL)
      account_id: "1234567"                 // Your New Relic account ID
      event_data: {                         // Custom event attributes
        appName: "MyApplication"
        environment: "production"
        userId: "user_12345"
        action: "purchase"
        value: 99.99
        productId: "prod_456"
      }
    }
  }
  env = ["NEW_RELIC_INSERT_KEY"]
}
```

### Calling the Function Directly

You can also call the `submit_event` function from other XanoScript code:

```xs
function "track_user_action" {
  input {
    text user_id
    text action_name
    decimal action_value
  }
  stack {
    // Call the submit_event function
    function.submit_event {
      input = {
        event_type: "UserAction",
        account_id: "1234567",
        event_data: {
          userId: $input.user_id,
          action: $input.action_name,
          value: $input.action_value,
          timestamp: now|to_text
        }
      }
    } as $event_result
  }
  response = $event_result
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `event_type` | text | Yes | - | Event type name (e.g., `PurchaseEvent`, `UserAction`). This appears in NRQL queries. |
| `account_id` | text | Yes | - | Your New Relic account ID (found in your New Relic account settings) |
| `event_data` | object | Yes | - | Object containing custom event attributes/fields |

## Response

On success, returns:

```json
{
  "success": true,
  "event_type": "PurchaseEvent",
  "account_id": "1234567",
  "events_accepted": true,
  "message": "Event submitted successfully"
}
```

## Error Handling

The job handles these error scenarios:

- **Input validation errors** (400): Missing required fields (event_type, account_id, or event_data)
- **Authentication errors** (401/403): Invalid or expired New Relic Insert API Key
- **Validation errors** (400): Malformed event data or invalid event type name
- **New Relic API errors** (500): Other New Relic API failures

All attempts (success or failure) are logged to the `event_log` table.

## File Structure

```
~/xs/newrelic-submit-event/
├── run.xs                    # Run job definition
├── function/
│   └── submit_event.xs       # Main event submission function
├── table/
│   └── event_log.xs          # Table for logging submissions
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Querying Events in New Relic

Once events are submitted, you can query them using NRQL in New Relic:

```sql
-- View all events of a specific type
SELECT * FROM PurchaseEvent SINCE 1 hour ago

-- Aggregate data
SELECT count(*), average(value) FROM UserAction WHERE action = 'purchase' SINCE 24 hours ago TIMESERIES

-- Filter by custom attributes
SELECT * FROM CustomEvent WHERE environment = 'production' AND appName = 'MyApplication'
```

## Testing

For testing, you can use a New Relic account with a free tier. The Insert API key is different from your license key - make sure you're using the correct key type.

## Security Notes

- Never commit your `NEW_RELIC_INSERT_KEY` to version control
- Use environment variables or Xano's secret management
- The job validates inputs before calling New Relic
- All event submissions are logged for audit purposes
- The Insert API key only allows sending events, not querying data

## Links

- [New Relic Event API Docs](https://docs.newrelic.com/docs/data-apis/ingest-apis/event-api/introduction-event-api/)
- [NRQL Reference](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/introduction-nrql-new-relics-query-language/)
- [New Relic API Keys](https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/)
