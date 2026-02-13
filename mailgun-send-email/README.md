# Mailgun Send Email Run Job

A XanoScript run job that sends emails via Mailgun API - perfect for transactional emails, notifications, and marketing campaigns.

## What It Does

This run job sends emails through Mailgun, enabling:
- **Transactional emails** - Order confirmations, password resets, welcome emails
- **Notifications** - Alerts, updates, system messages
- **Marketing emails** - Promotions, newsletters (with proper opt-in)
- **HTML or plain text** - Flexible content formatting

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `mailgun_api_key` | Your Mailgun API key (starts with `key-`) |
| `mailgun_domain` | Your Mailgun domain (e.g., `mg.yourdomain.com`) |

Get your credentials from: https://app.mailgun.com/app/dashboard

## How to Use

### 1. Set Environment Variables

```bash
export mailgun_api_key="key-your_key_here"
export mailgun_domain="mg.yourdomain.com"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Email

Edit the `input` block in `run.xs`:

```xs
run.job "Mailgun Send Email" {
  main = {
    name: "mailgun_send_email"
    input: {
      to: "customer@example.com"
      from: "noreply@yourdomain.com"
      subject: "Welcome to Our Service!"
      text: "Thanks for signing up! We're excited to have you."
      html: "<h1>Welcome!</h1><p>Thanks for <b>signing up</b>!</p>"
    }
  }
  env = ["mailgun_api_key", "mailgun_domain"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | email | Yes | Recipient email address |
| `from` | text | Yes | Sender email address (must be from your domain) |
| `subject` | text | Yes | Email subject line |
| `text` | text | No | Plain text version of the email |
| `html` | text | No | HTML version of the email |

**Note:** At least one of `text` or `html` should be provided.

## File Structure

```
mailgun-send-email/
├── run.xs                              # Run job configuration
├── functions/
│   └── mailgun_send_email.xs           # Function that calls Mailgun API
└── README.md                           # This file
```

## API Reference

This implementation uses the Mailgun Messages API:

- Endpoint: `POST https://api.mailgun.net/v3/{domain}/messages`
- Documentation: https://documentation.mailgun.com/en/latest/api-sending.html#sending

## Authentication

Mailgun uses HTTP Basic Authentication:
- Username: `api`
- Password: Your API key

The function encodes these as a Base64 `Authorization` header.

## Response

On success, the function returns:

```json
{
  "success": true,
  "message_id": "<20240115123456.123456789@mg.yourdomain.com>",
  "to": "customer@example.com",
  "from": "noreply@yourdomain.com",
  "subject": "Welcome to Our Service!"
}
```

## Domain Setup

Before sending emails, you need to:

1. Add your domain in Mailgun dashboard
2. Verify domain ownership (DNS records)
3. Wait for domain to be active

## Testing

For testing without affecting reputation, use Mailgun's sandbox domain:
- Sandbox domains are pre-configured
- Limited to authorized recipients only
- Add recipients in the Mailgun dashboard

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (to, from, subject)
- Invalid email formats
- Mailgun API errors (authentication, domain issues, etc.)

## License

MIT
