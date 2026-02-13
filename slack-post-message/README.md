# Slack Post Message Run Job

A XanoScript run job that posts messages to a Slack channel using the Slack Web API.

## What It Does

This run job automates posting messages to Slack channels. It uses Slack's `chat.postMessage` API endpoint to send messages with support for link unfurling and media previews.

## Features

- Posts messages to any Slack channel (public or private)
- Supports link unfurling and media previews
- Validates all required configuration before execution
- Comprehensive logging for monitoring and debugging
- Error handling with descriptive error messages

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `slack_bot_token` | Slack Bot User OAuth Token | `xoxb-YOUR-TOKEN-HERE` |
| `slack_channel_id` | Channel ID or name to post to | `#general` or `C1234567890` |
| `slack_message_text` | The message text to post | `Hello from Xano! 🚀` |

## Getting a Slack Bot Token

1. Go to [https://api.slack.com/apps](https://api.slack.com/apps) and create a new app
2. Navigate to **OAuth & Permissions** in the left sidebar
3. Add the following bot token scopes under **Scopes**:
   - `chat:write` - Send messages as the bot
   - `chat:write.public` - Send messages to public channels (optional)
4. Click **Install to Workspace** and authorize the app
5. Copy the **Bot User OAuth Token** (starts with `xoxb-`)

## Channel Format

The channel can be specified as:
- Channel name with `#`: `#general`
- Channel ID: `C1234567890`
- Direct message: `@username` or user ID

## Schedule

By default, this task is scheduled to run every hour starting from the configuration date. You can modify the `schedule` block in `run.job.xs` to change the frequency.

## Example Response

On success, the run job returns:

```json
{
  "success": true,
  "channel": "C1234567890",
  "timestamp": "1707772800.123456",
  "message_text": "Hello from Xano! 🚀",
  "posted_at": "2024-02-12T16:00:00.000Z"
}
```

## Error Handling

The run job will throw errors for:
- Missing or invalid Slack bot token
- Missing channel configuration
- Missing message text
- Slack API errors (invalid channel, rate limiting, etc.)

## Testing

To test this run job:

1. Set the required environment variables in your Xano workspace
2. Manually trigger the task from the Xano dashboard
3. Check the task history for execution logs

## File Structure

```
slack-post-message/
├── run.job.xs      # The main task definition
└── README.md       # This documentation
```

## API Reference

This run job uses the [Slack Web API chat.postMessage](https://api.slack.com/methods/chat.postMessage) method.

## License

MIT
