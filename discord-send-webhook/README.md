# Discord Send Webhook - Xano Run Job

This Xano Run Job sends messages to Discord channels using [Discord Webhooks](https://discord.com/developers/docs/resources/webhook). It's a simple way to post notifications from Xano to Discord servers.

## What It Does

1. Accepts message parameters (content, username, avatar URL)
2. Sends the message to Discord via webhook
3. Logs the webhook call to the `webhook_log` table
4. Returns the HTTP status and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `DISCORD_WEBHOOK_URL` | Your Discord webhook URL (get from Server Settings → Integrations → Webhooks) |

## Setup Instructions

1. In your Discord server, go to **Server Settings** → **Integrations** → **Webhooks**
2. Click **New Webhook**
3. Choose a channel and name your webhook
4. Click **Copy Webhook URL**
5. Set it as the `DISCORD_WEBHOOK_URL` environment variable in Xano

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "Discord Send Webhook"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Discord Send Webhook" {
  main = {
    name: "send_discord_webhook"
    input: {
      content: "🚀 Deployment completed successfully!"
      username: "Deploy Bot"
      avatar_url: "https://example.com/avatar.png"
    }
  }
  env = ["DISCORD_WEBHOOK_URL"]
}
```

### Function Inputs

The `send_discord_webhook` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `content` | text | Yes | - | The message content (max 2000 characters) |
| `username` | text | No | "Xano Bot" | Username to display as the sender |
| `avatar_url` | text | No | "" | URL for the avatar image (optional) |

### Response

```json
{
  "success": true,
  "http_status": 204,
  "log_id": 1
}
```

### Error Response

If the Discord API returns an error:

```json
{
  "name": "DiscordError",
  "value": "Discord API error: HTTP 429"
}
```

## Files

- `run.xs` - Run job configuration
- `function/send_discord_webhook.xs` - Webhook sending logic
- `table/webhook_log.xs` - Database table for logging webhook calls

## Notes

- Discord webhooks return HTTP 204 on success (no response body)
- Rate limits: 30 requests per 60 seconds per webhook
- Message content limited to 2000 characters
- The webhook must not be deleted in Discord for this to work
- Discord supports [rich embeds](https://discord.com/developers/docs/resources/message#embed-object) for more advanced formatting (not implemented here, but extendable)
- Common errors include HTTP 429 (rate limited) and HTTP 404 (webhook deleted)