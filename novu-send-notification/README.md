# Novu Send Notification Run Job

This Xano run job sends notifications via [Novu](https://novu.co), an open-source notification infrastructure platform.

## What It Does

This run job triggers a notification workflow in Novu to send messages to subscribers across multiple channels (email, SMS, push, in-app).

## Files

```
novu-send-notification/
├── run.xs                    # Run job configuration
├── function/
│   └── send_notification.xs  # Main function to send notifications
└── README.md                 # This file
```

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `NOVU_API_KEY` | Your Novu API key | Novu Dashboard → Settings → API Keys |

## How to Use

### Basic Usage

Trigger the run job with default parameters:

```bash
# This will send a notification to subscriber "user_123" using the "welcome-email" workflow
```

### Custom Parameters

The `send_novu_notification` function accepts:

- **subscriber_id** (string, required): The unique identifier of the subscriber in Novu
- **workflow_id** (string, required): The workflow/trigger identifier from your Novu dashboard
- **payload** (object, optional): Dynamic data to pass to your notification template (e.g., `{ "firstName": "John", "orderId": "12345" }`)

### Example Payloads

**Welcome Email:**
```json
{
  "subscriber_id": "user_123",
  "workflow_id": "welcome-email",
  "payload": {
    "firstName": "Jane",
    "companyName": "Acme Inc"
  }
}
```

**Order Confirmation:**
```json
{
  "subscriber_id": "user_456",
  "workflow_id": "order-confirmation",
  "payload": {
    "orderId": "ORD-789",
    "total": "$99.99",
    "items": 3
  }
}
```

## Novu Setup

1. Create a free account at [https://novu.co](https://novu.co)
2. Create a workflow in the Novu dashboard
3. Get your API key from Settings → API Keys
4. Set the `NOVU_API_KEY` environment variable in Xano

## API Reference

This run job uses the Novu Events API:

- **Endpoint**: `POST https://api.novu.co/v1/events/trigger`
- **Documentation**: https://docs.novu.co/api-reference/events/trigger-event

## Response

On success, the function returns:

```json
{
  "success": true,
  "transaction_id": "txn_abc123",
  "status": "pending"
}
```

## Error Handling

The function handles these error cases:

- **401 Unauthorized**: Invalid API key
- **404 Not Found**: Workflow ID doesn't exist
- **Other errors**: Returns detailed error message from Novu API
