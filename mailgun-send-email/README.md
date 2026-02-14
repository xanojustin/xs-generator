# Mailgun Send Email Run Job

This Xano Run Job sends emails using the Mailgun API.

## What It Does

This run job demonstrates how to send transactional emails via Mailgun using XanoScript. It includes:

- A reusable `send_email` function that makes HTTP requests to Mailgun's API
- Support for both plain text and HTML email bodies
- Error handling for common API failure scenarios
- Environment variable configuration for security

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `MAILGUN_API_KEY` | Your Mailgun API key | `key-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` |
| `MAILGUN_DOMAIN` | Your verified Mailgun domain | `mg.yourdomain.com` |

## Setup

1. Sign up for a [Mailgun](https://www.mailgun.com/) account
2. Verify your domain in the Mailgun dashboard
3. Get your API key from the Mailgun dashboard (Settings → API Keys)
4. Set the environment variables in your Xano workspace

## Usage

### As a Run Job

The run job is configured with example values. Update the `input` block in `run.xs` with your actual email details:

```xs
run.job "Mailgun Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "user@example.com"
      from: "noreply@yourdomain.com"
      subject: "Welcome to our service!"
      text_body: "Thanks for signing up!"
      html_body: "<h1>Welcome!</h1><p>Thanks for signing up!</p>"
    }
  }
  env = ["MAILGUN_API_KEY", "MAILGUN_DOMAIN"]
}
```

### As a Function

Call the `send_email` function from other XanoScript code:

```xs
function.run "send_email" {
  input = {
    to: "recipient@example.com"
    from: "sender@yourdomain.com"
    subject: "Hello from Xano!"
    text_body: "This is the plain text version."
    html_body: "<p>This is the <strong>HTML</strong> version.</p>"
  }
} as $result
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | text | Yes | Recipient email address |
| `from` | text | Yes | Sender email address (must be verified in Mailgun) |
| `subject` | text | Yes | Email subject line |
| `text_body` | text | No | Plain text email body (required if html_body not provided) |
| `html_body` | text | No | HTML email body (required if text_body not provided) |
| `mailgun_domain` | text | No | Override the MAILGUN_DOMAIN env var |

## Response Format

### Success
```json
{
  "success": true,
  "message_id": "<20240101000000.123456789@mg.yourdomain.com>",
  "message": "Email sent successfully"
}
```

### Error (Authentication Failed)
```json
{
  "success": false,
  "error": "Authentication failed. Check your MAILGUN_API_KEY environment variable.",
  "status": 401
}
```

## File Structure

```
mailgun-send-email/
├── run.xs                    # Run job definition
├── function/
│   └── send_email.xs         # Email sending function
└── README.md                 # This file
```

## API Reference

This integration uses the [Mailgun Messages API](https://documentation.mailgun.com/en/latest/api-sending.html):

- **Endpoint**: `POST https://api.mailgun.net/v3/{domain}/messages`
- **Authentication**: Basic Auth (username: `api`, password: `{api_key}`)
- **Content-Type**: `application/x-www-form-urlencoded`

## Notes

- The `from` address must be verified in your Mailgun account
- Free Mailgun accounts can only send to authorized recipients
- HTML emails should include a plain text fallback for better deliverability
