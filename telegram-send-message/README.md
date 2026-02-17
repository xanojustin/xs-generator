# Telegram Send Message - Xano Run Job

This Xano Run Job sends a message to a Telegram chat using the Telegram Bot API.

## What It Does

The run job sends a text message to a specified Telegram chat using an HTTP POST request
to the Telegram Bot API. Messages can be formatted using HTML tags (bold, italic, links, etc.).

## Prerequisites

1. Create a Telegram Bot via [@BotFather](https://t.me/botfather)
2. Save your bot token - you'll need it as an environment variable
3. Get your chat ID (you can use [@userinfobot](https://t.me/userinfobot) to find it)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `telegram_bot_token` | Your Telegram bot token from @BotFather (format: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`) |

## How to Use

### Run with Default Values

The job is pre-configured with sample values:
- chat_id: `7984772893`
- message: `Hello from Xano Run Job!`

### Run with Custom Values

Modify the `input` block in `run.xs`:

```xs
run.job "Send Telegram Message" {
  main = {
    name: "send_telegram_message"
    input: {
      chat_id: "YOUR_CHAT_ID"
      message: "Your custom message here!"
    }
  }
  env = ["telegram_bot_token"]
}
```

### Message Formatting

Telegram supports HTML formatting in messages:
- `<b>bold</b>` - Bold text
- `<i>italic</i>` - Italic text
- `<u>underline</u>` - Underlined text
- `<s>strikethrough</s>` - Strikethrough text
- `<a href="https://example.com">link</a>` - Clickable links
- `<code>inline code</code>` - Inline code

## File Structure

```
telegram-send-message/
├── run.xs              # Job configuration
├── function/
│   └── send_telegram_message.xs  # Function that sends the message
└── README.md           # This file
```

## API Reference

- [Telegram Bot API Documentation](https://core.telegram.org/bots/api#sendmessage)
- Endpoint: `POST https://api.telegram.org/bot<token>/sendMessage`

## Response

The function returns:

```json
{
  "success": true,
  "status_code": 200,
  "response": { ...telegram api response... }
}
```

## Error Handling

If the message fails to send, check:
1. Your bot token is correct
2. The bot has been started (send `/start` to your bot in Telegram)
3. The chat_id is correct
4. The bot is not blocked by the user
