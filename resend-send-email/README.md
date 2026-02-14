# Resend Send Email - Xano Run Job

This Xano Run Job sends emails using the [Resend](https://resend.com) API - a modern email platform for developers.

## What It Does

This run job sends transactional emails via Resend's API. It supports:
- HTML email content
- Plain text fallback
- Custom sender address
- Reply-to configuration

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `resend_api_key` | Your Resend API key | From [Resend Dashboard](https://resend.com/api-keys) |

## File Structure

```
resend-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Email sending logic
└── README.md           # This file
```

## How to Use

### 1. Set up your environment variable

In your Xano workspace, set the `resend_api_key` environment variable with your Resend API key.

### 2. Configure the run job

Edit `run.xs` to customize the default email parameters:

```xs
run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "your@email.com"
      subject: "Your Subject"
      html: "<p>Your HTML content</p>"
    }
  }
  env = ["resend_api_key"]
}
```

### 3. Deploy and run

Deploy to Xano Job Runner and execute the job.

## Input Parameters

The `send_email` function accepts these inputs:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | email | Yes | Recipient email address |
| `subject` | text | Yes | Email subject line |
| `html` | text | Yes | HTML email body |
| `text_body` | text | No | Plain text version (optional) |
| `from` | email | No | Sender address (defaults to onboarding@resend.dev) |
| `reply_to` | text | No | Reply-to email address |

## Response Format

On success:
```json
{
  "success": true,
  "message_id": "uuid-string",
  "to": "recipient@example.com",
  "status": "sent"
}
```

On failure:
```json
{
  "success": false,
  "error": "Error message",
  "status_code": 400
}
```

## Notes

- New Resend accounts must verify a domain before sending to arbitrary addresses
- The default `from` address (`onboarding@resend.dev`) only works for sending to your own verified email
- For production use, verify your domain in Resend and set a custom `from` address

## API Reference

- [Resend API Documentation](https://resend.com/docs/api-reference/emails/send-email)
