# Slack Send Message - Xano Run Job

This Xano Run Job sends messages to Slack channels using the Slack Web API.

## What It Does

This run job calls the Slack `chat.postMessage` API endpoint to send a text message to a specified Slack channel.

## Prerequisites

1. A Slack workspace where you have permission to add apps
2. A Slack app with a Bot Token

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `SLACK_BOT_TOKEN` | Slack Bot User OAuth Token | Create a Slack app at https://api.slack.com/apps, add `chat:write` bot scope, install to workspace |

## Slack App Setup

1. Go to https://api.slack.com/apps and click "Create New App"
2. Choose "From scratch" and give your app a name
3. Navigate to **OAuth & Permissions** in the left sidebar
4. Under **Scopes** → **Bot Token Scopes**, add:
   - `chat:write` - Send messages to channels
5. Click **Install to Workspace** and authorize the app
6. Copy the **Bot User OAuth Token** (starts with `xoxb-`)
7. Invite the bot to your channel by typing `/invite @YourBotName` in Slack

## Usage

### Default Behavior

By default, the run job sends "Hello from Xano Run Job!" to the `#general` channel.

### Customizing Input

Edit `run.xs` to change the input parameters:

```xs
run.job "Send Slack Message" {
  main = {
    name: "send_slack_message"
    input: {
      channel: "#my-channel"
      message: "Custom message here!"
    }
  }
  env = ["SLACK_BOT_TOKEN"]
}
```

### Running the Job

```bash
# Set your Slack bot token
export SLACK_BOT_TOKEN="xoxb-your-token-here"

# Run the job (via Xano Job Runner)
xano job run ./run.xs
```

## File Structure

```
slack-send-message/
├── run.xs                      # Run job configuration
├── function/
│   └── send_slack_message.xs   # Core function logic
└── README.md                   # This file
```

## API Reference

This job uses the Slack Web API:
- **Endpoint**: `POST https://slack.com/api/chat.postMessage`
- **Documentation**: https://api.slack.com/methods/chat.postMessage

## Response

On success, the function returns:

```json
{
  "success": true,
  "channel": "C1234567890",
  "timestamp": "1234567890.123456",
  "message": "Message sent successfully to #general"
}
```

## Error Handling

The job validates:
- Required input fields (channel, message)
- Environment variable presence (SLACK_BOT_TOKEN)
- HTTP response status codes
- Slack API response (`ok: true`)

Errors are thrown with descriptive messages for debugging.

## License

MIT
