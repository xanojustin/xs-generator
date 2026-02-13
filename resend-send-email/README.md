# Resend Send Email - Xano Run Job

This Xano run job sends transactional emails using the Resend API.

## What It Does

The run job executes a function that sends an HTML email via Resend. It handles:

- Authentication with Resend using API key
- Formatting the API request with proper JSON payload
- Sending the email via Resend's Emails API
- Returning success/error status with response details including email ID

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `resend_api_key` | Your Resend API key (starts with re_) | `re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` |

## Optional Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `resend_from_email` | The sender email address | `onboarding@resend.dev` |

## How to Use

### 1. Set Environment Variables

Configure the required environment variable in your Xano workspace settings:

```
resend_api_key = re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Optionally set the from email:

```
resend_from_email = notifications@yourdomain.com
```

### 2. Run the Job

Execute the run job using the Xano CLI or dashboard:

```bash
xano run execute resend-send-email
```

### 3. Customize the Email

Modify `run.xs` to change the recipient, subject, or HTML content:

```xs
run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "user@example.com"
      subject: "Welcome to Our App!"
      html: "<h1>Welcome!</h1><p>Thanks for signing up.</p>"
    }
  }
  env = ["resend_api_key", "resend_from_email"]
}
```

## File Structure

```
resend-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Email sending function
├── README.md           # This file
└── FEEDBACK.md         # Development feedback for MCP improvements
```

## Resend API Reference

- **Endpoint**: `POST https://api.resend.com/emails`
- **Auth**: Bearer token (API key)
- **Content-Type**: `application/json`
- **Request Body**:
  - `from`: Sender email address (must be verified in Resend)
  - `to`: Recipient email address
  - `subject`: Email subject line
  - `html`: HTML content of the email

## Response Format

### Success Response

```json
{
  "status": "success",
  "message": "Email sent successfully. ID: 12345678-1234-1234-1234-123456789abc",
  "resend_response": {
    "id": "12345678-1234-1234-1234-123456789abc",
    "from": "onboarding@resend.dev",
    "to": "recipient@example.com",
    "created_at": "2024-01-15T10:30:00.000Z"
  }
}
```

### Error Response

```json
{
  "status": "error",
  "message": "Failed to send email. Status: 403, Error: The from address must be a verified domain",
  "resend_response": {
    "message": "The from address must be a verified domain",
    "name": "validation_error"
  }
}
```

## Getting a Resend API Key

1. Sign up at https://resend.com
2. Navigate to API Keys in your dashboard
3. Create a new API key with "Sending access"
4. Copy the key (starts with `re_`)

## Domain Verification

To send from your own domain:

1. Add your domain in the Resend dashboard
2. Configure the DNS records (SPF, DKIM, DMARC)
3. Wait for verification
4. Use your verified domain in the `from` field

For testing, you can use `onboarding@resend.dev` or `noreply@resend.dev` without verification.

## Notes

- Free tier: 100 emails/day
- Paid plans available for higher volumes
- Supports attachments (not implemented in this basic example)
- Supports batch sending (not implemented in this basic example)
