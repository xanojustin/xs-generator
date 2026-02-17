# Brevo Send Transactional Email

A XanoScript run job that sends transactional emails using the [Brevo](https://www.brevo.com/) (formerly Sendinblue) API.

## What It Does

This run job sends transactional emails via the Brevo API. It's perfect for:

- Welcome emails for new users
- Password reset notifications
- Order confirmations
- Appointment reminders
- Any automated transactional messaging

## Prerequisites

1. A Brevo account (free tier available)
2. A verified sender email address in your Brevo dashboard
3. Your Brevo API key

## Setup

### 1. Get Your Brevo API Key

1. Sign up or log in to [Brevo](https://www.brevo.com/)
2. Go to **SMTP & API** in the left sidebar
3. Click on the **API Keys** tab
4. Create a new API key or use an existing v3 key
5. Copy the API key (it starts with `xkeysib-`)

### 2. Verify Your Sender Email

1. In Brevo, go to **Senders, Domains, & Dedicated IPs** → **Senders**
2. Add and verify your sender email address
3. The sender email must be verified before sending emails

### 3. Set Environment Variable

Set the `BREVO_API_KEY` environment variable in your Xano workspace:

```
BREVO_API_KEY=xkeysib-your-api-key-here
```

## File Structure

```
brevo-send-email/
├── run.xs                              # Run job configuration
├── function/
│   └── send_transactional_email.xs     # Email sending logic
└── README.md                           # This file
```

## Usage

### Running the Job

Execute the run job with your desired email parameters:

```bash
xano run --job brevo-send-email
```

Or trigger via the Xano Run API with custom input.

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | email | Yes | Recipient email address |
| `to_name` | text | No | Recipient display name |
| `subject` | text | Yes | Email subject line |
| `html_content` | text | Yes | HTML version of the email body |
| `text_content` | text | Yes | Plain text version (fallback) |
| `sender_email` | email | Yes | Verified sender email address |
| `sender_name` | text | No | Sender display name |

### Example Input

```json
{
  "to_email": "user@example.com",
  "to_name": "John Doe",
  "subject": "Welcome to Our Platform",
  "html_content": "<h1>Welcome!</h1><p>Thanks for signing up.</p>",
  "text_content": "Welcome! Thanks for signing up.",
  "sender_email": "noreply@yourcompany.com",
  "sender_name": "Your Company"
}
```

### Response

On success:

```json
{
  "success": true,
  "message": "Email sent successfully",
  "message_id": "<message-id-here>",
  "email": "user@example.com",
  "subject": "Welcome to Our Platform",
  "sent_at": "2026-02-17T08:45:00.000Z"
}
```

## Error Handling

The run job handles common error scenarios:

| Error | Cause | Solution |
|-------|-------|----------|
| `InvalidRequest` | Missing or invalid input fields | Check all required fields are provided |
| `Unauthorized` | Invalid API key | Verify your `BREVO_API_KEY` environment variable |
| `SenderNotVerified` | Sender email not verified in Brevo | Verify the sender email in Brevo dashboard |
| `APIError` | Other Brevo API errors | Check Brevo API documentation for details |

## Brevo API Documentation

- [Brevo API Reference](https://developers.brevo.com/reference/sendtransacemail)
- [Transactional Emails Guide](https://developers.brevo.com/docs/transactional-emails)

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `BREVO_API_KEY` | Yes | Your Brevo v3 API key |

## Rate Limits

Brevo has rate limits based on your plan:
- Free plan: 300 emails/day
- Starter plan: 20,000 emails/month
- Business plan: 100,000+ emails/month

Check your [Brevo dashboard](https://app.brevo.com/) for current limits.

## License

MIT
