# Courier Send Notification

A Xano Run Job that sends notifications using the [Courier](https://www.courier.com/) API. Courier is a notification infrastructure platform that allows developers to send notifications across multiple channels (email, SMS, push, chat, etc.) using a single unified API.

## What This Run Job Does

This run job sends email notifications via Courier's API. It:

1. Takes a template ID, recipient email, and optional data
2. Builds a properly formatted Courier API payload
3. Sends the notification request to Courier
4. Returns the request ID and status for tracking

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `COURIER_AUTH_TOKEN` | Your Courier API authentication token (found in Courier Dashboard > Settings > API Keys) |

## How to Use

### Basic Usage

```bash
# Set your Courier API token
export COURIER_AUTH_TOKEN="your_courier_auth_token_here"

# Run the job
xano run
```

### With Input Parameters

When running via the Xano Run API, pass these parameters:

```json
{
  "template_id": "your_template_id",
  "recipient_email": "user@example.com",
  "recipient_id": "user_123",
  "data": {
    "user_name": "John Doe",
    "order_id": "ORD-12345"
  }
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `template_id` | text | Yes | The Courier template ID to use for the notification |
| `recipient_email` | text | Yes | The email address of the recipient |
| `recipient_id` | text | No | A unique identifier for the recipient (defaults to email) |
| `data` | json | No | Data object to pass to the template for variable substitution |

### Response

```json
{
  "success": true,
  "request_id": "1-61f3a8b4-1234567890abcdef",
  "status": "queued",
  "recipient": "user@example.com",
  "template": "your_template_id"
}
```

## Setting Up Courier

1. Create a free account at [courier.com](https://www.courier.com/)
2. Create a notification template in the Courier Designer
3. Connect at least one provider (SendGrid, AWS SES, etc.)
4. Get your Auth Token from Settings > API Keys
5. Set the `COURIER_AUTH_TOKEN` environment variable

## Files

```
courier-send-notification/
├── run.xs                          # Run job configuration
├── function/
│   └── send_notification.xs        # Function that sends the notification
└── README.md                       # This file
```

## Error Handling

The run job will throw a `standard` error if:
- The Courier API returns a non-2xx status code
- The request times out (30 second timeout)
- Required parameters are missing

## Courier API Reference

- [Courier API Documentation](https://www.courier.com/docs/reference/)
- [Send API Endpoint](https://www.courier.com/docs/reference/send/)

## License

MIT
