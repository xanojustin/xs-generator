# Slack Post Message - Xano Run Job

This Xano Run Job posts a message to a Slack channel using the [Slack API](https://api.slack.com/methods/chat.postMessage) and logs the message to a database table.

## What It Does

1. Accepts message parameters (channel, message text, username, icon emoji)
2. Posts a message to Slack using the `chat.postMessage` API
3. Logs the message to the `message_log` table
4. Returns the Slack timestamp and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SLACK_BOT_TOKEN` | Your Slack Bot User OAuth Token (get from https://api.slack.com/apps) |

## Setup Instructions

1. Create a Slack App at https://api.slack.com/apps
2. Add the `chat:write` bot scope under OAuth & Permissions
3. Install the app to your workspace
4. Copy the Bot User OAuth Token (starts with `xoxb-`)
5. Set it as the `SLACK_BOT_TOKEN` environment variable in Xano

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "Slack Post Message"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Slack Post Message" {
  main = {
    name: "post_message"
    input: {
      channel: "#notifications"
      message: "Deployment completed successfully!"
      username: "Deploy Bot"
      icon_emoji: ":rocket:"
    }
  }
  env = ["SLACK_BOT_TOKEN"]
}
```

### Function Inputs

The `post_message` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `channel` | text | Yes | - | Slack channel ID (C123...) or name (#general) |
| `message` | text | Yes | - | The message text to post |
| `username` | text | No | "Xano Bot" | Username to display as the sender |
| `icon_emoji` | text | No | ":robot_face:" | Emoji to use as the bot icon |

### Response

```json
{
  "success": true,
  "slack_timestamp": "1234567890.123456",
  "slack_channel_id": "C1234567890",
  "log_id": 1
}
```

### Error Response

If the Slack API returns an error:

```json
{
  "name": "SlackError",
  "value": "Slack API error: channel_not_found"
}
```

## Files

- `run.xs` - Run job configuration
- `function/post_message.xs` - Message posting logic
- `table/message_log.xs` - Database table for logging messages

## Notes

- The bot must be a member of the channel to post messages
- Channel names should include the # prefix (e.g., #general)
- You can also use channel IDs (e.g., C1234567890)
- All messages are logged to `message_log` including failed attempts
- Common errors include `channel_not_found`, `not_in_channel`, and `invalid_auth`
