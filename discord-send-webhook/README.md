# Discord Webhook Run Job

This Xano Run Job sends messages to Discord channels using Discord's webhook API.

## What It Does

The `discord_webhook` function sends messages to a Discord server/channel via webhook URLs. This allows you to post notifications, alerts, or automated messages directly to Discord from your Xano workspace.

## Prerequisites

1. A Discord server where you have permission to create webhooks
2. A webhook URL from your Discord channel

### Creating a Discord Webhook

1. Open your Discord server
2. Go to the channel where you want to post messages
3. Click the gear icon (Channel Settings) next to the channel name
4. Select **Integrations** → **Webhooks** → **New Webhook**
5. Name your webhook and optionally upload an avatar
6. Click **Copy Webhook URL** - this is your `discord_webhook_url`

## Required Environment Variables

Set this in your Xano workspace environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `discord_webhook_url` | Your Discord webhook URL | `https://discord.com/api/webhooks/123456789/abc-def-ghi` |

## File Structure

```
discord-send-webhook/
├── run.xs                    # Run job configuration
├── function/
│   └── discord_webhook.xs    # Webhook sending function
└── README.md                 # This file
```

## Usage

### Running the Job

The job is configured with default values in `run.xs`:

```xs
run.job "Send Discord Webhook Message" {
  main = {
    name: "discord_webhook"
    input: {
      message: "🚀 Hello from Xano! This message was sent via a Discord webhook."
      username: "Xano Bot"
    }
  }
  env = ["discord_webhook_url"]
}
```

Update the `input` values in `run.xs` or pass them when executing.

### Function Parameters

The `discord_webhook` function accepts:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `message` | text | Yes | - | The message content to send (max 2000 characters) |
| `username` | text | No | "Xano Bot" | Custom username for the webhook message |
| `avatar_url` | text | No | "" | URL to a custom avatar image |

### Response

On success, returns:

```json
{
  "success": true,
  "status": "sent",
  "message": "Message sent to Discord successfully"
}
```

## Error Handling

The function handles common Discord webhook errors:

- **400 Bad Request**: Malformed JSON or message too long
- **401 Unauthorized**: Invalid webhook token
- **404 Not Found**: Webhook has been deleted or URL is wrong
- **429 Rate Limited**: Too many requests (Discord rate limits apply)
- **Other errors**: Generic API error messages

## Discord Limits

- **Message length**: Maximum 2000 characters for content
- **Rate limits**: Discord applies rate limiting to webhooks (typically 5 requests per 2 seconds)
- **Embeds**: This basic implementation sends plain text. For rich embeds, modify the payload structure.

## Use Cases

- Send notifications when new users sign up
- Alert on system errors or exceptions
- Post automated status updates
- Notify team members of new orders or support tickets
- Log important events from your application

## Security Notes

- Never commit your webhook URL to version control
- Keep your webhook URL private - anyone with the URL can post to your channel
- Use Xano environment variables for the webhook URL
- Consider regenerating the webhook URL if you suspect it's been compromised

## Discord Documentation

- [Discord Webhooks Guide](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)
- [Discord Developer Docs - Webhooks](https://discord.com/developers/docs/resources/webhook)
