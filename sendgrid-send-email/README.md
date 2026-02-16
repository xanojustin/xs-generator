# SendGrid Send Email Run Job

This Xano Run Job sends transactional emails using the SendGrid API.

## What It Does

This run job demonstrates how to send a welcome email using SendGrid's v3 Mail Send API. It includes:

- Email validation (recipient format checking)
- HTML email content support
- Configurable sender name and email
- Error handling for API failures
- Environment variable security for API keys

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SENDGRID_API_KEY` | Your SendGrid API key (starts with `SG.`) |

Get your API key from: https://app.sendgrid.com/settings/api_keys

## How to Use

### 1. Set Up Environment Variable

```bash
export SENDGRID_API_KEY="SG.xxxxxxxxxxxxxxxxxxxxxxxx"
```

### 2. Modify the Run Job

Edit `run.xs` to customize the email parameters:

```xs
run.job "Send Welcome Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "actual@recipient.com"    // Change this
      subject: "Your Custom Subject"        // Change this
      content: "<html>...</html>"           // Your HTML content
      from_name: "Your App Name"           // Sender display name
      from_email: "sender@yourdomain.com"  // Sender email address
    }
  }
  env = ["SENDGRID_API_KEY"]
}
```

### 3. Run the Job

```bash
xano run execute --job "Send Welcome Email"
```

Or use the Run API:

```bash
curl -X POST https://app.dev.xano.com/api:run/v1/run \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "job": "sendgrid-send-email",
    "env": {
      "SENDGRID_API_KEY": "SG.xxx"
    }
  }'
```

## Function Reference

### `send_email`

Sends a single transactional email via SendGrid.

**Input Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | text | Yes | Recipient email address |
| `subject` | text | Yes | Email subject line |
| `content` | text | Yes | HTML content of the email |
| `from_name` | text | No | Display name for sender (default: "Notification Service") |
| `from_email` | text | No | Sender email address (default: "noreply@example.com") |

**Response:**

```json
{
  "success": true,
  "to": "recipient@example.com",
  "subject": "Welcome!",
  "message_id": "abc123..."
}
```

## File Structure

```
sendgrid-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Email sending function
└── README.md           # This file
```

## Customization Ideas

- **Template Support**: Extend the function to use SendGrid dynamic templates
- **Batch Emails**: Modify to send to multiple recipients
- **Attachments**: Add file attachment support
- **Tracking**: Store sent emails in a database table
- **Retry Logic**: Add automatic retry on transient failures

## Resources

- SendGrid API Docs: https://docs.sendgrid.com/api-reference/mail-send/mail-send
- XanoScript Docs: Use `xanoscript_docs` MCP tool
