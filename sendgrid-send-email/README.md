# SendGrid Email Sender - Xano Run Job

This Xano Run Job sends transactional emails using the SendGrid API.

## What It Does

This run job demonstrates how to send emails via SendGrid using XanoScript. It includes:

- A `send_email` function that makes authenticated API requests to SendGrid
- Support for both plain text and HTML email bodies
- Configurable sender and recipient names
- Error handling and response validation

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `SENDGRID_API_KEY` | Your SendGrid API key | [SendGrid Dashboard](https://app.sendgrid.com/settings/api_keys) |

## File Structure

```
sendgrid-send-email/
├── run.xs                    # Run job configuration
├── function/
│   └── send_email.xs         # Email sending function
└── README.md                 # This file
```

## How to Use

### 1. Configure Environment Variables

Set the `SENDGRID_API_KEY` environment variable in your Xano workspace settings.

### 2. Customize the Email

Edit `run.xs` to change the email parameters:

```xs
run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "your-recipient@example.com"    // Change this
      to_name: "Recipient Name"                  // Optional
      from_email: "your-sender@example.com"      // Must be verified in SendGrid
      from_name: "Your App Name"                 // Optional
      subject: "Your Subject Line"
      body_text: "Plain text version..."
      body_html: "<html><body>...</body></html>"
    }
  }
  env = ["SENDGRID_API_KEY"]
}
```

### 3. Run the Job

Use the Xano CLI or dashboard to execute the run job.

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | text | Yes | Recipient email address |
| `to_name` | text | No | Recipient display name |
| `from_email` | text | Yes | Sender email address (must be verified in SendGrid) |
| `from_name` | text | No | Sender display name |
| `subject` | text | Yes | Email subject line |
| `body_text` | text | No* | Plain text email body |
| `body_html` | text | No* | HTML email body |

*At least one of `body_text` or `body_html` must be provided.

## Response Format

```json
{
  "success": true,
  "status_code": 202,
  "error": null
}
```

| Field | Description |
|-------|-------------|
| `success` | Boolean indicating if the email was accepted |
| `status_code` | HTTP status code from SendGrid (202 = accepted) |
| `error` | Error message if the request failed |

## Notes

- SendGrid returns HTTP 202 (Accepted) for successful email submissions
- The email may take a few moments to actually be delivered
- Make sure your sender email is verified in SendGrid (or your domain is authenticated)
- SendGrid has rate limits based on your plan tier

## Learn More

- [SendGrid API Documentation](https://docs.sendgrid.com/api-reference/mail-send/mail-send)
- [XanoScript Documentation](https://docs.xano.com)