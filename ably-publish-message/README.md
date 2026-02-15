# Ably Publish Message

A Xano Run Job that publishes real-time messages to Ably channels using the Ably REST API.

## What It Does

This run job publishes messages to Ably pub/sub channels, enabling real-time communication in your applications. Ably is a popular real-time messaging platform used for live chat, notifications, live updates, and more.

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `ABLY_API_KEY` | Your Ably API key in Basic auth format (base64 encoded `app_id:key`) | From [Ably Dashboard](https://ably.com/dashboard) → API Keys |

### Setting up ABLY_API_KEY

The Ably API key needs to be base64 encoded for Basic authentication:

```bash
# Format: base64("app_id:key")
# Example: If your app ID is "abc123" and key is "def456"
# The string to encode is: "abc123:def456"
echo -n "your_app_id:your_api_key" | base64
```

Use the resulting base64 string as your `ABLY_API_KEY` environment variable.

## How to Use

### Default Usage

The run job publishes a sample message to the `notifications` channel:

```bash
# Set your Ably API key
export ABLY_API_KEY="your_base64_encoded_api_key"

# Run the job
xano job run
```

### Customizing the Message

Edit the `input` section in `run.xs` to customize:

```xs
run.job "Ably Publish Message" {
  main = {
    name: "publish_message"
    input: {
      channel: "your-channel-name"      // Target Ably channel
      event_name: "your.event.name"     // Event name for subscribers
      data: {
        // Your custom message payload
        title: "Custom Title"
        body: "Custom message body"
        user_id: 123
        priority: "high"
      }
    }
  }
  env = ["ABLY_API_KEY"]
}
```

## File Structure

```
ably-publish-message/
├── run.xs                          # Run job configuration
├── function/
│   └── publish_message.xs          # Main publishing function
└── README.md                       # This file
```

## Function Parameters

### publish_message

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `channel` | text | Yes | The Ably channel name to publish to |
| `event_name` | text | Yes | The event name that subscribers listen for |
| `data` | object | Yes | The message payload (any JSON-serializable object) |

## Response

On success, the function returns:

```json
{
  "success": true,
  "channel": "notifications",
  "event": "user.notification",
  "message_id": "abc123...",
  "timestamp": "2026-02-15T11:15:00Z"
}
```

## Error Handling

The function handles these error cases:
- **Input Validation**: Missing required fields return `inputerror`
- **401 Unauthorized**: Invalid API key
- **400 Bad Request**: Malformed request payload
- **API Errors**: Other Ably API errors with detailed messages

## Subscribing to Messages

To receive messages published by this job, clients can subscribe using Ably SDKs:

### JavaScript Example
```javascript
const Ably = require('ably');
const client = new Ably.Realtime('your-client-api-key');

const channel = client.channels.get('notifications');
channel.subscribe('user.notification', (message) => {
  console.log('Received:', message.data);
});
```

## Resources

- [Ably Documentation](https://ably.com/docs)
- [Ably REST API Reference](https://ably.com/docs/api/rest-api)
- [Ably Dashboard](https://ably.com/dashboard)
