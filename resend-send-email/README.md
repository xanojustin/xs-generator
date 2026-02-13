# Resend Send Email Run Job

A XanoScript run job that sends emails using the [Resend](https://resend.com) API.

## What It Does

This run job sends transactional emails via Resend's modern email API. Resend is a developer-focused email platform built by the same team behind React Email, offering:

- Simple, clean API
- High deliverability
- Real-time webhook events
- Beautiful email templates support

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `RESEND_API_KEY` | Your Resend API key (starts with `re_`) |

Get your API key from: https://resend.com/api-keys

## How to Use

### Run the Job

The job is configured to run with default test values. You can modify the input in `run.xs`:

```xs
run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano!"
      html: "<p>Your HTML content here</p>"
      from: "sender@yourdomain.com"  // Optional
      reply_to: "replies@yourdomain.com"  // Optional
    }
  }
  env = ["RESEND_API_KEY"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | email | Yes | Recipient email address |
| `subject` | text | Yes | Email subject line |
| `html` | text | Yes | HTML content of the email |
| `from` | text | No | Sender address (default: `onboarding@resend.dev`) |
| `reply_to` | text | No | Reply-to email address |

### Response

On success, returns:

```json
{
  "success": true,
  "message_id": "uuid-of-sent-message",
  "to": "recipient@example.com",
  "subject": "Hello from Xano!"
}
```

## File Structure

```
~/xs/resend-send-email/
├── run.xs                 # Job configuration
├── functions/
│   └── send_email.xs      # Email sending function
└── README.md              # This file
```

## Testing

1. Set your `RESEND_API_KEY` environment variable in Xano
2. Verify your sender domain in Resend (or use the default test domain)
3. Run the job via the Xano Job Runner

## Notes

- For production use, verify your domain in Resend and update the `from` address
- Resend's free tier includes 100 emails/day
- Check Resend dashboard for delivery status and analytics

## API Reference

- Resend API Docs: https://resend.com/docs/api-reference/emails/send-email
