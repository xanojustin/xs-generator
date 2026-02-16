# MessageBird Send SMS

A Xano Run Job that sends SMS messages using the MessageBird (Bird) API.

## What It Does

This run job sends SMS messages to a specified phone number using MessageBird's REST API. It's useful for:

- Sending transactional SMS notifications
- Sending verification codes
- Sending alerts and reminders
- Integrating SMS into your workflows

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MESSAGEBIRD_API_KEY` | Your MessageBird API key (Bearer token) |
| `MESSAGEBIRD_WORKSPACE_ID` | Your MessageBird workspace ID |
| `MESSAGEBIRD_CHANNEL_ID` | Your SMS channel ID |

## How to Use

### As a Run Job

The job is configured in `run.xs` with default values. To run:

```bash
xano run execute --job="MessageBird Send SMS"
```

### With Custom Parameters

Call the `send_sms` function directly with your own inputs:

```xs
run.job "Send Custom SMS" {
  main = {
    name: "send_sms"
    input: {
      recipient: "+1234567890"
      message_body: "Your custom message here"
      originator: "YourBrand"
    }
  }
  env = ["MESSAGEBIRD_API_KEY", "MESSAGEBIRD_WORKSPACE_ID", "MESSAGEBIRD_CHANNEL_ID"]
}
```

### Function Inputs

| Input | Type | Required | Description |
|-------|------|----------|-------------|
| `recipient` | text | Yes | Phone number in E.164 format (e.g., +1234567890) |
| `message_body` | text | Yes | The SMS message content |
| `originator` | text | No | Sender ID (defaults to "Bird") |

### Response

On success, the function returns:

```json
{
  "success": true,
  "message_id": "msg_abc123",
  "status": "sent",
  "recipient": "+1234567890",
  "body": "Hello from Xano via MessageBird!"
}
```

## Getting MessageBird Credentials

1. Sign up at [bird.com](https://bird.com)
2. Create a workspace
3. Add an SMS channel
4. Generate an API key with `channel:send` permissions
5. Note your workspace ID and channel ID from the dashboard

## API Reference

This uses the Bird REST API:
- Endpoint: `POST /workspaces/{workspace_id}/channels/{channel_id}/messages`
- Docs: https://docs.bird.com/api/send-sms
