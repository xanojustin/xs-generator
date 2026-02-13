# Discord Send Message - Xano Run Job

This Xano run job sends messages to Discord via webhook.

## What It Does

Sends customizable messages to a Discord channel using Discord's webhook API. Supports custom usernames and avatar URLs.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `DISCORD_WEBHOOK_URL` | Your Discord webhook URL (get this from Discord channel settings) |

## How to Use

### Setup Discord Webhook

1. In Discord, go to your server settings
2. Navigate to Integrations → Webhooks
3. Click "New Webhook"
4. Choose the channel and copy the webhook URL
5. Set this URL as the `DISCORD_WEBHOOK_URL` environment variable in Xano

### Running the Job

The job is configured with default inputs but can be customized:

```xs
run.job "Discord Send Message" {
  main = {
    name: "send_discord_message"
    input: {
      content: "Your custom message here!"
      username: "Custom Bot Name"
      avatar_url: "https://example.com/avatar.png"
    }
  }
  env = ["DISCORD_WEBHOOK_URL"]
}
```

### Function Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `content` | text | Yes | The message content to send |
| `username` | text | No | Custom bot name (overrides webhook default) |
| `avatar_url` | text | No | Custom avatar image URL |

## Files

- `run.xs` - Run job configuration
- `function/send_discord_message.xs` - The function that sends the webhook

## API Reference

Uses Discord's Webhook API: https://discord.com/developers/docs/resources/webhook
