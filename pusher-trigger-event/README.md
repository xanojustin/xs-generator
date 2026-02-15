# Pusher Trigger Event Run Job

This XanoScript run job triggers a real-time event on Pusher Channels, enabling instant message delivery to connected clients.

## What It Does

This run job publishes events to Pusher Channels for real-time updates. It handles:

- Publishing events to specified channels
- Supporting custom event names and message payloads
- Authenticating with Pusher using App ID, Key, and Secret
- Returning event confirmation IDs
- Error handling for common failure scenarios

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `PUSHER_APP_ID` | Your Pusher application ID (e.g., `1234567`) |
| `PUSHER_KEY` | Your Pusher app key (e.g., `abc123def456`) |
| `PUSHER_SECRET` | Your Pusher app secret (e.g., `xyz789uvw321`) |
| `PUSHER_CLUSTER` | Your Pusher cluster (e.g., `us2`, `eu`, `ap1`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `channel` | text | Yes | Channel name to publish to (e.g., `notifications`, `chat-room-1`) |
| `event` | text | Yes | Event name to trigger (e.g., `new-message`, `user-joined`) |
| `message` | text | Yes | Message payload to send to subscribers |

### Response

```json
{
  "success": true,
  "event_id": "1234567890abcdef",
  "channel": "my-channel",
  "event": "my-event",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "event_id": null,
  "channel": "my-channel",
  "event": "my-event",
  "error": "Pusher API error: HTTP 401 - Invalid credentials"
}
```

## File Structure

```
pusher-trigger-event/
├── run.xs                    # Run job definition
├── function/
│   └── trigger_event.xs      # Function to trigger Pusher event
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Use Cases

- **Chat Applications**: Broadcast new messages to chat room participants
- **Notifications**: Push real-time alerts to users
- **Live Updates**: Sync data across clients (sports scores, stock prices)
- **Activity Feeds**: Show real-time activity streams
- **Collaboration**: Notify users of document changes

## Pusher Documentation

- [Pusher Channels Docs](https://pusher.com/docs/channels)
- [Publishing Events](https://pusher.com/docs/channels/library_auth_reference/rest-api#post-event-trigger-an-event)
- [Client SDKs](https://pusher.com/docs/channels/channels_libraries/libraries)

## Testing

1. Create a free Pusher account at [pusher.com](https://pusher.com)
2. Create a new Channels app
3. Copy your App ID, Key, Secret, and Cluster to environment variables
4. Run the job with test values
5. Use the Pusher Debug Console to verify events are received

## Client-Side Example (JavaScript)

```javascript
const pusher = new Pusher('YOUR_KEY', {
  cluster: 'us2'
});

const channel = pusher.subscribe('my-channel');
channel.bind('my-event', function(data) {
  console.log('Received:', data);
});
```

## Security Notes

- Never commit your `PUSHER_SECRET` to version control
- Use private channels for sensitive data
- Implement channel authorization for authenticated users
- Consider rate limiting to prevent abuse
