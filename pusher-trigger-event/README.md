# Pusher Trigger Event

A Xano Run Job that triggers real-time events on Pusher channels.

## What It Does

This run job sends real-time events to connected clients via Pusher's WebSocket infrastructure. Use it to:

- Notify users of new messages or updates
- Broadcast live data changes
- Trigger UI updates in real-time applications
- Send notifications to specific channels

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `PUSHER_APP_ID` | Your Pusher application ID |
| `PUSHER_KEY` | Your Pusher app key |
| `PUSHER_SECRET` | Your Pusher app secret |

## How to Use

### Basic Usage

The run job is configured in `run.xs` with default values:

```xs
run.job "Pusher Trigger Event" {
  main = {
    name: "trigger_event"
    input: {
      channel: "my-channel"
      event_name: "my-event"
      data: { message: "Hello from Xano!" }
    }
  }
}
```

### Function Parameters

The `trigger_event` function accepts:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `channel` | text | Yes | The Pusher channel name |
| `event_name` | text | Yes | The event name to trigger |
| `data` | json | Yes | The event payload (any JSON object) |
| `socket_id` | text | No | Exclude this socket from receiving the event |

### Customizing the Event

Edit `run.xs` to change the input parameters:

```xs
input: {
  channel: "notifications"
  event_name: "user-notification"
  data: { 
    type: "info",
    message: "Your task is complete!",
    user_id: 123
  }
}
```

## Getting Pusher Credentials

1. Sign up at [pusher.com](https://pusher.com)
2. Create a new app
3. Navigate to **App Keys** in your dashboard
4. Copy the App ID, Key, and Secret

## Folder Structure

```
pusher-trigger-event/
├── run.xs              # Run job configuration
├── function/
│   └── trigger_event.xs # Event trigger logic
└── README.md           # This file
```

## Response Format

On success:
```json
{
  "success": true,
  "message": "Event triggered successfully",
  "channel": "my-channel",
  "event": "my-event",
  "response": { }
}
```

On failure:
```json
{
  "success": false,
  "error": "Failed to trigger event",
  "status_code": 401,
  "response": { }
}
```
