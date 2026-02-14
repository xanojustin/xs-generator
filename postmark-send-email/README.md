# Postmark Send Email - Xano Run Job

This Xano Run Job sends transactional emails using the [Postmark](https://postmarkapp.com) API.

## What It Does

This run job sends transactional emails through Postmark's reliable email delivery service. It supports HTML and plain text content, tagging for organization, and reply-to addresses.

## Features

- Send transactional emails via Postmark API
- HTML and plain text body support
- Email tagging for tracking/categorization
- Custom reply-to addresses
- Comprehensive error handling

## Folder Structure

```
~/xs/postmark-send-email/
├── run.xs                    # Run job configuration
├── function/
│   └── send_email.xs         # Email sending function
└── README.md                 # This file
```

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `postmark_server_token` | Your Postmark server API token | From your Postmark server settings → API Tokens tab |

## Postmark Setup

1. Sign up at [postmarkapp.com](https://postmarkapp.com)
2. Create a server in your Postmark account
3. Verify your sender signature or add your domain
4. Copy your Server API Token from the API Tokens tab
5. Set it as the `postmark_server_token` environment variable in Xano

## Input Parameters

### Required

| Parameter | Type | Description |
|-----------|------|-------------|
| `to` | email | Recipient email address |
| `subject` | text | Email subject line |
| `html_body` | text | HTML content of the email |

### Optional

| Parameter | Type | Description |
|-----------|------|-------------|
| `from` | email | Sender email (must be verified in Postmark) |
| `text_body` | text | Plain text version (for email clients without HTML support) |
| `tag` | text | Tag for categorizing/tracking emails |
| `reply_to` | text | Reply-to email address |

## Usage

### Default Usage

The run job comes with default values for testing:

```
to: "recipient@example.com"
subject: "Hello from Xano via Postmark"
html_body: "<p>This email was sent using Postmark API via Xano Run Job.</p>"
```

### Custom Parameters

Modify `run.xs` to customize the email:

```xs
run.job "Postmark Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "customer@example.com"
      subject: "Welcome to Our Service!"
      html_body: "<h1>Welcome!</h1><p>Thanks for signing up.</p>"
      text_body: "Welcome! Thanks for signing up."
      tag: "welcome-email"
      from: "noreply@yourdomain.com"
    }
  }
  env = ["postmark_server_token"]
}
```

## Response

### Success Response

```json
{
  "success": true,
  "message_id": "b7bc2f4a-e38f-4b09-9bbd-4f2e9e8c4c6d",
  "to": "recipient@example.com",
  "submitted_at": "2026-02-13T18:45:00.000Z",
  "status": "OK"
}
```

### Error Response

```json
{
  "success": false,
  "error_code": 406,
  "error": "You tried to send to a recipient that has been marked as inactive.",
  "status_code": 422
}

```

## Common Postmark Error Codes

| Code | Meaning |
|------|---------|
| 0 | OK - Success |
| 400 | Bad Request |
| 401 | Unauthorized - Invalid API token |
| 422 | Unprocessable Entity - Validation error |
| 406 | Inactive recipient |
| 409 | Conflicting resource |
| 500 | Internal Server Error |

## Resources

- [Postmark Documentation](https://postmarkapp.com/developer)
- [Postmark API Reference](https://postmarkapp.com/developer/api/email-api)
- [Postmark Error Codes](https://postmarkapp.com/developer/api/overview#error-codes)
