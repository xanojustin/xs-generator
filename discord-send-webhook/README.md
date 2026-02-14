# Discord Send Webhook - Xano Run Job

This Xano Run Job sends rich messages to Discord channels using Discord's webhook API.

## What It Does

The run job executes a function that sends a formatted message (with optional rich embeds) to a Discord channel via a webhook URL. Perfect for:
- Sending notifications from your applications
- Alerting on system events
- Posting formatted updates with rich embeds
- Building chat integrations

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `discord_webhook_url` | Your Discord webhook URL (e.g., `https://discord.com/api/webhooks/...`) |

## How to Get a Discord Webhook URL

1. Open Discord and go to the channel where you want to receive messages
2. Click the channel settings (gear icon) or right-click the channel name
3. Go to **Integrations** → **Webhooks**
4. Click **New Webhook**
5. Give it a name and optional avatar
6. Click **Copy Webhook URL**
7. Set this as your `discord_webhook_url` environment variable

## How to Use

1. Set your Discord webhook URL as the `discord_webhook_url` environment variable
2. Run the job to send a test message:

```bash
# The default configuration sends a test message
# Modify the input in run.xs to customize your message
```

### Modifying Input Parameters

Edit the `run.xs` file to customize your Discord message:

```xs
run.job "Send Discord Webhook" {
  main = {
    name: "send_discord_webhook"
    input: {
      // Simple text message (optional if using embed)
      content: "@here New order received!"
      
      // Bot name override (optional)
      username: "My App Bot"
      
      // Bot avatar override (optional)
      avatar_url: "https://example.com/avatar.png"
      
      // Rich embed title
      title: "New Order #12345"
      
      // Rich embed description (supports markdown)
      description: "**Customer:** John Doe\n**Amount:** $99.99\n**Status:** Paid"
      
      // Embed color (decimal color code)
      color: "3066993"  // Green
      
      // Footer text
      footer_text: "Order System"
    }
  }
  env = ["discord_webhook_url"]
}
```

## File Structure

```
discord-send-webhook/
├── run.xs                    # Run job configuration
├── function/
│   └── send_discord_webhook.xs  # Discord webhook function
└── README.md                 # This file
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `content` | text | No | Simple text message content. Required if no embed fields provided. |
| `username` | text | No | Override the bot's display name |
| `avatar_url` | text | No | Override the bot's avatar image URL |
| `title` | text | No | Rich embed title (triggers embed mode) |
| `description` | text | No | Rich embed description (supports Discord markdown) |
| `color` | text | No | Embed color as decimal (default: 3447003/Xano blue) |
| `footer_text` | text | No | Footer text displayed at bottom of embed |

## Color Codes

Common Discord embed colors (decimal):

| Color | Decimal |
|-------|---------|
| Red | 15158332 |
| Green | 3066993 |
| Blue | 3447003 |
| Yellow | 16776960 |
| Purple | 10181046 |
| Orange | 15105570 |
| Black | 2303786 |
| White | 16777215 |

## Response

On success, the function returns:

```json
{
  "success": true,
  "status": 204,
  "message": "Message sent successfully to Discord"
}
```

## Error Handling

The function validates inputs and handles API errors:
- Missing webhook URL returns a config error
- Missing content AND embed fields returns an input error
- Discord API errors are caught and thrown with descriptive messages
- Invalid webhook URLs will return 404 errors

## Discord Markdown Support

The description field supports Discord's markdown:
- `**bold**` → **bold**
- `*italic*` → *italic*
- `__underline__` → __underline__
- `~~strikethrough~~` → ~~strikethrough~~
- `\`code\`` → `code`
- `\`\`\`multiline code\`\`\`` → code blocks
- `> quote` → blockquotes

## Rate Limits

Discord webhooks have rate limits (typically 5 requests per 2 seconds). The function does not implement rate limiting - implement delays between calls if sending multiple messages.