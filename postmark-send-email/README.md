# Postmark Send Email

A Xano Run Job that sends transactional emails via the Postmark API.

## Overview

This run job sends a single transactional email using Postmark, a reliable email delivery service for applications. It's perfect for welcome emails, notifications, receipts, and other transactional messages.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `postmark_api_key` | Your Postmark server API key (starts with your server token) |
| `postmark_from_email` | The verified sender email address in your Postmark account |

### Setting Up Postmark

1. Sign up at [postmarkapp.com](https://postmarkapp.com)
2. Create a server and get your Server API Token
3. Verify your sender signature (the from email address)
4. Set the environment variables in your Xano workspace

## Usage

### Running the Job

The job is configured with default inputs in `run.xs`. You can modify the input values there or pass them when running the job.

Default configuration:
```
to: "recipient@example.com"
subject: "Hello from Postmark"
body: "This is a test email sent via Postmark API."
```

### Function Parameters

The `send_email` function accepts these inputs:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | text | Yes | Recipient email address |
| `subject` | text | Yes | Email subject line |
| `body` | text | Yes | Plain text email body content |

### Example Response

On success:
```json
{
  "success": true,
  "message": "Email sent successfully via Postmark",
  "recipient": "user@example.com",
  "subject": "Your receipt"
}
```

## File Structure

```
postmark-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Email sending function
└── README.md           # This file
```

## API Reference

This job uses the Postmark Email API:
- **Endpoint**: `POST https://api.postmarkapp.com/email`
- **Documentation**: https://postmarkapp.com/developer/api/email-api

## Error Handling

The job validates:
- All required input fields are present
- Environment variables are configured
- API response status (throws error on non-200 responses)

Common errors:
- `inputerror` - Missing required fields
- `PostmarkAPIError` - API returned an error with message
- `standard` - Missing environment variables

## Rate Limits

Postmark rate limits vary by plan. Check your account settings for details.
