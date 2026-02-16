# Resend Send Email Run Job

This Xano Run Job sends transactional emails using the [Resend](https://resend.com) API - a modern, developer-friendly email platform.

## What It Does

This run job demonstrates how to send transactional emails using Resend's REST API. It includes:

- Email validation (recipient format checking)
- HTML email content support
- Configurable sender name and email
- Optional CC and BCC recipients
- Optional Reply-To address
- Error handling for API failures
- Environment variable security for API keys

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `RESEND_API_KEY` | Your Resend API key (starts with `re_`) |

Get your API key from: https://resend.com/api-keys

## How to Use

### 1. Set Up Environment Variable

```bash
export RESEND_API_KEY="re_xxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### 2. Verify Sender Domain

Resend requires you to verify your sender domain before sending emails. 
- Use `onboarding@resend.dev` for testing (no domain verification needed)
- Or verify your domain at: https://resend.com/domains

### 3. Modify the Run Job

Edit `run.xs` to customize the email parameters:

```xs
run.job "Send Email via Resend" {
  main = {
    name: "send_email"
    input: {
      to_email: "actual@recipient.com"    // Change this
      subject: "Your Custom Subject"        // Change this
      content: "<html>...</html>"           // Your HTML content
      from_name: "Your App Name"           // Sender display name
      from_email: "sender@yourdomain.com"  // Must be a verified domain
    }
  }
  env = ["RESEND_API_KEY"]
}
```

### 4. Run the Job

```bash
xano run execute --job "Send Email via Resend"
```

Or use the Run API:

```bash
curl -X POST https://app.dev.xano.com/api:run/v1/run \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "job": "resend-send-email",
    "env": {
      "RESEND_API_KEY": "re_xxx"
    }
  }'
```

## Function Reference

### `send_email`

Sends a transactional email via Resend.

**Input Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | text | Yes | Recipient email address |
| `subject` | text | Yes | Email subject line |
| `content` | text | Yes | HTML content of the email |
| `from_name` | text | No | Display name for sender (default: "Notification Service") |
| `from_email` | text | No | Sender email address (default: "onboarding@resend.dev") |
| `cc_emails` | text[] | No | Array of CC recipient email addresses |
| `bcc_emails` | text[] | No | Array of BCC recipient email addresses |
| `reply_to` | text | No | Reply-to email address |

**Response:**

```json
{
  "success": true,
  "to": "recipient@example.com",
  "subject": "Welcome!",
  "message_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "from": "Your App <sender@domain.com>"
}
```

## File Structure

```
resend-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Email sending function
├── README.md           # This file
└── FEEDBACK.md         # MCP feedback documentation
```

## Why Resend?

Resend is a modern alternative to traditional email providers:

- **Developer Experience**: Simple, clean REST API
- **Deliverability**: Built for transactional emails
- **Real-time Analytics**: Track opens, clicks, and deliveries
- **Modern Infrastructure**: Built for speed and reliability
- **Competitive Pricing**: Pay-as-you-go with generous free tier

## Customization Ideas

- **Batch Emails**: Modify to send to multiple recipients efficiently
- **Templates**: Use Resend's React Email templates for consistent designs
- **Attachments**: Add file attachment support via the `attachments` field
- **Analytics**: Store email events in a database for tracking
- **Retry Logic**: Add exponential backoff for transient failures

## Resources

- Resend API Docs: https://resend.com/docs/api-reference/emails/send-email
- Resend Dashboard: https://resend.com
- XanoScript Docs: Use `xanoscript_docs` MCP tool
