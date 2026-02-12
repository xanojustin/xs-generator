# SendGrid Send Email - Xano Run Job

A XanoScript run job that sends emails using the SendGrid API and logs them to a database.

## What It Does

This run job sends an email via SendGrid's REST API and maintains a log of all sent emails in a local database table.

## Features

- ✅ Sends emails via SendGrid API v3
- ✅ Logs all sent emails to database
- ✅ Input validation with clear error messages
- ✅ Configurable sender name
- ✅ Database indexing for fast queries

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `SENDGRID_API_KEY` | Your SendGrid API key | `SG.xxx...` |
| `SENDGRID_FROM_EMAIL` | Verified sender email address | `noreply@yourdomain.com` |

## How to Get SendGrid Credentials

1. Sign up at [sendgrid.com](https://sendgrid.com)
2. Create an API key with "Mail Send" permissions
3. Verify your sender email address or domain
4. Add these to your Xano environment variables

## Usage

### Run the Job

```bash
# With default values
xano run run.xs

# With custom input (via Xano Job Runner)
```

### Function Input Parameters

```json
{
  "to": "recipient@example.com",
  "subject": "Your Subject Here",
  "body": "Email body content here...",
  "from_name": "Your App Name"  // Optional, defaults to "Xano App"
}
```

### Database Table: `email_log`

Tracks all sent emails with:
- `id` - Auto-incrementing primary key
- `to_email` - Recipient email address
- `subject` - Email subject line
- `sent_at` - Timestamp of when sent
- `status` - Delivery status ("sent" or "failed")
- `error_message` - Error details if failed

## File Structure

```
sendgrid-send-email/
├── run.xs              # Job configuration
├── functions/
│   └── send_email.xs   # Main email sending function
├── tables/
│   └── email_log.xs    # Email logging table
└── README.md           # This file
```

## API Reference

Uses SendGrid Mail Send API v3:
- Endpoint: `POST https://api.sendgrid.com/v3/mail/send`
- Docs: https://docs.sendgrid.com/api-reference/mail-send/mail-send

## Extending

Ideas for enhancement:
- Add HTML email support (add `text/html` content type)
- Support attachments using SendGrid's attachments array
- Add CC/BCC recipients
- Implement email templates using SendGrid's template system
- Add retry logic for failed sends
- Query email stats from SendGrid's API