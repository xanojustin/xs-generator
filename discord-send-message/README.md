# Discord Send Message Run Job

A XanoScript run job that sends messages to Discord channels via webhook.

## What It Does

This run job sends messages to a Discord channel using Discord's webhook API:
- **Sends text messages** - Post simple text messages to any Discord channel
- **Supports custom username** - Override the webhook's default name per message
- **Supports custom avatar** - Set a custom avatar URL for the message
- **Supports embeds** - Send rich embed messages (optional)

Perfect for notifications, alerts, logging, or any automated messaging to Discord.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `discord_webhook_url` | Your Discord webhook URL (starts with `https://discord.com/api/webhooks/...`) |

### How to Get a Discord Webhook URL

1. Open Discord and go to your server
2. Right-click on the channel you want to post to
3. Select **Server Settings** → **Integrations** → **Webhooks**
4. Click **New Webhook**
5. Choose the channel and click **Copy Webhook URL**

## How to Use

### 1. Set the Environment Variable

```bash
export discord_webhook_url="https://discord.com/api/webhooks/123456789/abcdef..."
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Message

Edit the `input` block in `run.xs` to customize:

```xs
run.job "Discord Send Message" {
  main = {
    name: "discord_send_message"
    input: {
      webhook_url: $env.discord_webhook_url
      content: "Server alert: CPU usage exceeded 90%!"
      username: "Monitoring Bot"
      avatar_url: "https://example.com/alert-icon.png"
    }
  }
  env = ["discord_webhook_url"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `webhook_url` | text | Yes | Discord webhook URL |
| `content` | text | Yes | Message content to send (max 2000 characters) |
| `username` | text | No | Custom username to display for this message |
| `avatar_url` | text | No | Custom avatar URL for this message |
| `embeds` | list | No | Array of embed objects for rich messages |

### Example with Embeds

```xs
run.job "Discord Send Message" {
  main = {
    name: "discord_send_message"
    input: {
      webhook_url: $env.discord_webhook_url
      content: ""
      embeds: [
        {
          title: "New User Registered",
          description: "A new user just signed up!",
          color: 3447003,
          fields: [
            { name: "Email", value: "user@example.com", inline: true },
            { name: "Plan", value: "Pro", inline: true }
          ],
          timestamp: "2024-01-15T10:30:00.000Z"
        }
      ]
    }
  }
  env = ["discord_webhook_url"]
}
```

## File Structure

```
discord-send-message/
├── run.xs                              # Run job configuration
├── functions/
│   └── discord_send_message.xs         # Function that calls Discord webhook API
└── README.md                           # This file
```

## API Reference

This implementation uses Discord's webhook API:

### Execute Webhook
- Endpoint: `POST https://discord.com/api/webhooks/{webhook.id}/{webhook.token}`
- Documentation: https://discord.com/developers/docs/resources/webhook#execute-webhook

## Response

On success, the function returns:

```json
{
  "success": true,
  "status": 204,
  "message_id": null,
  "channel_id": null,
  "content_sent": "Hello from Xano! This is a test message sent via Discord webhook."
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing webhook URL
- Missing message content
- Discord API errors (invalid webhook, rate limits, etc.)

## License

MIT
