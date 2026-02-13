# SendGrid Send Email - Xano Run Job

This Xano Run Job sends emails using the SendGrid API v3.

## What It Does

This run job demonstrates how to integrate with SendGrid's email API to send transactional emails. It includes:

- A `run.job` configuration that executes the email sending function
- A `send_email` function that makes HTTP requests to SendGrid's API
- Support for HTML email content
- Error handling and response formatting

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `sendgrid_api_key` | Your SendGrid API key (starts with `SG.`) | Yes |
| `sendgrid_from_email` | Default sender email address | No (defaults to `noreply@example.com`) |

## How to Use

### 1. Set up environment variables

In your Xano workspace, set the `sendgrid_api_key` environment variable with your SendGrid API key.

### 2. Run the job

The job is configured with default input values:
- **to**: `recipient@example.com`
- **subject**: `Hello from Xano!`
- **html**: `<p>This is a test email sent via the SendGrid API using XanoScript.</p>`

### 3. Customize input

Modify the `input` object in `run.xs` to customize the email:

```xs
run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "user@example.com"
      subject: "Welcome to our platform!"
      html: "<h1>Welcome!</h1><p>Thanks for signing up.</p>"
    }
  }
  env = ["sendgrid_api_key", "sendgrid_from_email"]
}
```

## API Reference

This run job uses the SendGrid v3 Mail Send API:

- **Endpoint**: `POST https://api.sendgrid.com/v3/mail/send`
- **Authentication**: Bearer token (API key)
- **Documentation**: https://docs.sendgrid.com/api-reference/mail-send/mail-send

## File Structure

```
sendgrid-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Email sending function
└── README.md           # This file
```

## Response Format

The function returns an object with the following structure:

```json
{
  "status": "success" | "error",
  "message": "Human-readable status message",
  "sendgrid_response": { ... }  // Raw API response
}
```

## Notes

- SendGrid returns `202 Accepted` for successful email submissions
- The API key must have "Mail Send" permissions
- For production use, consider adding input validation and rate limiting
