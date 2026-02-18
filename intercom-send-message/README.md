# Intercom Send Message

A Xano run job that sends messages to users via the Intercom customer messaging platform.

## What It Does

This run job sends personalized messages to users through Intercom's messaging API. It supports different message types including email, and can be used for:

- Sending transactional notifications to users
- Automated welcome messages
- Important account updates
- Custom notification workflows

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `INTERCOM_ACCESS_TOKEN` | Your Intercom API access token (Workspace App Token) | ✅ Yes |
| `INTERCOM_ADMIN_ID` | The admin ID to send messages from | ⚠️ Optional (uses default if not set) |

## Getting Your Intercom Credentials

1. **Access Token**: Go to Intercom Developer Hub → Your App → Configure → Authentication
   - Generate a Workspace App Token with `Read/Write` permissions for Messages
   
2. **Admin ID**: Go to Intercom Settings → Teammates
   - Copy the admin ID from the URL or API explorer

## Usage

### Basic Usage

When running the job, provide these inputs:

```json
{
  "user_id": "user_12345",
  "message_body": "Hello! Welcome to our platform. Let us know if you need any help.",
  "message_type": "email"
}
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `user_id` | text | ✅ Yes | - | The Intercom user ID to send the message to |
| `message_body` | text | ✅ Yes | - | The message content (HTML supported) |
| `message_type` | text | No | "email" | Message type: "email" or "inapp" |

### Example

```bash
# Using the Xano CLI
xano run execute --job="Send Intercom Message" --input='{"user_id":"123","message_body":"Hello!"}'
```

## Response

On success, returns:

```json
{
  "success": true,
  "message_id": "msg_abc123",
  "created_at": "2024-01-15T10:30:00.000Z"
}
```

## Error Handling

The job handles common error cases:

- **400/401**: Invalid API credentials
- **404**: User not found
- **500**: Intercom API errors

## File Structure

```
intercom-send-message/
├── run.xs                      # Run job configuration
├── function/
│   └── intercom_send_message.xs # Main function logic
└── README.md                   # This file
```

## Intercom API Reference

- [Intercom Messages API](https://developers.intercom.com/docs/references/rest-api/api.intercom.io/messages/)
- [Authentication](https://developers.intercom.com/docs/references/authentication/)

## License

MIT
