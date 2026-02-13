# Slack Send Message - Xano Run Job

This Xano run job sends a message to a Slack channel using the Slack API.

## What It Does

The run job executes a function that posts a message to a specified Slack channel. It handles:

- Authentication with Slack using your Bot User OAuth Token
- Sending messages to any valid Slack channel (public, private, or direct message)
- Proper error handling for missing credentials or API failures
- Returning detailed response information including the message timestamp

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `slack_bot_token` | Your Slack Bot User OAuth Token (starts with `xoxb-...`) | `xoxb-123456789012-...` |
| `slack_channel` | The channel ID or name to send the message to | `#general` or `C1234567890` |
| `slack_message` | The message text to send | `Hello from Xano!` |

## How to Get a Slack Bot Token

1. Go to [Slack API Apps](https://api.slack.com/apps) and create a new app
2. Navigate to **OAuth & Permissions** in the left sidebar
3. Add the `chat:write` and `chat:write.public` bot token scopes
4. Install the app to your workspace
5. Copy the **Bot User OAuth Token** (starts with `xoxb-`)

## How to Use

### 1. Set Environment Variables

Configure the required environment variables in your Xano workspace settings.

### 2. Run the Job

Execute the run job using the Xano CLI or dashboard:

```bash
xano run execute slack-send-message
```

### 3. Customize the Message

Set the `slack_message` to your desired text. You can use:
- Plain text
- Emoji (e.g., `:wave:` becomes 👋)
- Basic Markdown (e.g., `*bold*`, `_italic_`, `<https://example.com|link text>`)

## File Structure

```
slack-send-message/
├── run.xs                      # Run job configuration
├── function/
│   └── send_slack_message.xs   # Message sending function
├── README.md                   # This file
└── FEEDBACK.md                 # Development feedback for MCP improvements
```

## Slack API Reference

- **Endpoint**: `POST https://slack.com/api/chat.postMessage`
- **Auth**: Bearer Token (Bot User OAuth Token)
- **Parameters**:
  - `channel`: Channel ID (e.g., `C1234567890`) or name (e.g., `#general`)
  - `text`: The message text to post

## Response Format

### Success

```json
{
  "status": "success",
  "message": "Message sent successfully to #general",
  "channel": "C1234567890",
  "timestamp": "1234567890.123456",
  "slack_response": { ... }
}
```

### Error

```json
{
  "status": "error",
  "message": "Slack API error: channel_not_found",
  "slack_response": { ... }
}
```

## Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `channel_not_found` | Channel doesn't exist or bot isn't invited | Verify channel ID/name and invite the bot to private channels |
| `not_in_channel` | Bot isn't a member of the private channel | Invite the bot to the channel |
| `invalid_auth` | Token is invalid or expired | Check your Bot User OAuth Token |
| `missing_scope` | Bot doesn't have required permissions | Add `chat:write` scope in OAuth settings |
| `msg_too_long` | Message exceeds 40,000 characters | Shorten your message |

## Inviting the Bot to Channels

For **public channels**: The bot can post to any public channel automatically.

For **private channels**: You must invite the bot:
1. In Slack, go to the private channel
2. Type `/invite @YourBotName`
3. The bot will now be able to post messages

## Advanced Usage

### Using Block Kit (Rich Messages)

To send rich formatted messages with buttons, sections, or images, you can extend this function to include the `blocks` parameter instead of `text`.

### Threading Messages

Add a `thread_ts` parameter to reply in a thread:
```json
{
  "channel": "C1234567890",
  "text": "Reply in thread",
  "thread_ts": "1234567890.123456"
}
```

## Security Notes

- Never expose your Bot Token in client-side code
- Store the token as an environment variable
- Use the principle of least privilege - only add necessary OAuth scopes
- Rotate tokens periodically for security
- Monitor your Slack app's audit logs for unusual activity

## Rate Limits

Slack enforces rate limits:
- **Tier 1**: 1+ request per second (for `chat.postMessage`)
- If rate limited, the API returns a `429` status with a `Retry-After` header

See [Slack Rate Limits](https://api.slack.com/docs/rate-limits) for details.
