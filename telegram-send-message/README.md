# Telegram Send Message Run Job

A Xano Run Job that sends messages via the Telegram Bot API.

## What It Does

This run job sends a text message to a Telegram chat or channel using the Telegram Bot API. It supports:
- HTML and Markdown formatting
- Silent notifications (no sound)
- Private chats, groups, and channels
- Error handling with meaningful messages

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `telegram_bot_token` | Your Telegram Bot API token (from @BotFather) |

## How to Get a Bot Token

1. Message [@BotFather](https://t.me/botfather) on Telegram
2. Send `/newbot` and follow the prompts
3. Copy the bot token provided

## How to Find Your Chat ID

**For private chats:**
- Message [@userinfobot](https://t.me/userinfobot) and it will reply with your ID

**For groups:**
- Add the bot to the group
- Send a message in the group
- Visit: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
- Look for `"chat":{"id":-123456789` — the negative number is your chat ID

**For channels:**
- Use the channel username with @ (e.g., `@mychannel`)
- Or forward a message from the channel to [@userinfobot](https://t.me/userinfobot)

## Usage

### Running the Job

```bash
# Set your bot token as an environment variable
export telegram_bot_token="123456789:ABCdefGHIjklMNOpqrSTUvwxyz"

# Run the job (with default message)
xano run

# Or with custom inputs
xano run --input '{"chat_id": "@mychannel", "message": "Custom message!"}'
```

### Supported Message Formats

**HTML (default):**
```html
<b>Bold text</b>
<i>Italic text</i>
<code>inline code</code>
<a href="https://example.com">Link</a>
```

**Markdown:**
```markdown
*bold text*
_italic text_
`inline code`
[link](https://example.com)
```

## File Structure

```
telegram-send-message/
├── run.xs                    # Run job configuration
├── function/
│   └── send_telegram_message.xs  # Function that calls Telegram API
└── README.md                 # This file
```

## API Reference

This job uses the Telegram Bot API:
- Endpoint: `POST https://api.telegram.org/bot<token>/sendMessage`
- Documentation: https://core.telegram.org/bots/api#sendmessage

## Error Handling

The function handles common errors:
- **401 Unauthorized**: Invalid bot token
- **400 Bad Request**: Invalid chat ID or malformed message
- **API errors**: Returns descriptive error messages from Telegram

## Example Response

```json
{
  "success": true,
  "message_id": 123,
  "chat_id": -1001234567890,
  "date": 1707849600
}
```

## Security Notes

- Never commit your bot token to version control
- Use environment variables or Xano's secret management
- The bot must be a member of the target chat/channel
- For channels, the bot needs "Post Messages" permission
