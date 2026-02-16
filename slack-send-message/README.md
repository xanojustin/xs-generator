# Slack Send Message Run Job

A Xano Run Job that sends messages to Slack channels using the Slack Web API.

## What It Does

This run job sends automated messages to a specified Slack channel. It uses the `chat.postMessage` endpoint from Slack's Web API to post messages as a bot user.

## Files

- `run.xs` - Run job configuration that defines the entry point
- `function/send_slack_message.xs` - Function that handles the Slack API integration

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SLACK_BOT_TOKEN` | Your Slack Bot User OAuth Token (starts with `xoxb-`) |

### Getting a Slack Bot Token

1. Go to [Slack API Apps](https://api.slack.com/apps)
2. Create a New App → From scratch
3. Go to **OAuth & Permissions**
4. Add the `chat:write` bot scope
5. Install the app to your workspace
6. Copy the **Bot User OAuth Token**

## Usage

### Running the Job

```bash
xano run execute --job slack-send-message
```

### Customizing the Message

Edit `run.xs` to change the channel and message:

```xs
run.job "Slack Send Message" {
  main = {
    name: "send_slack_message"
    input: {
      channel: "#your-channel"
      message: "Your custom message here"
    }
  }
  env = ["SLACK_BOT_TOKEN"]
}
```

### Inviting the Bot to a Channel

Before the bot can post to a channel, you need to invite it:

1. In Slack, go to the channel
2. Type `/invite @YourBotName`
3. The bot will join and can now receive messages

## Response

On success, the function returns:

```json
{
  "success": true,
  "channel": "C1234567890",
  "timestamp": "1234567890.123456",
  "message_text": "Hello from Xano Run Job!"
}
```

## Error Handling

The function validates:
- Channel name is not empty
- Message text is not empty  
- SLACK_BOT_TOKEN environment variable is set
- Slack API returns a successful response

Common errors:
- `channel_not_found` - The channel doesn't exist or the bot isn't a member
- `not_in_channel` - The bot needs to be invited to the channel
- `invalid_auth` - The bot token is invalid

## API Reference

- [Slack chat.postMessage API](https://api.slack.com/methods/chat.postMessage)
