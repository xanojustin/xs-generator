# Postmark Send Email - Xano Run Job

A XanoScript integration for sending transactional emails via the Postmark API. This run job provides both a reusable email function and a scheduled health check task.

## What This Run Job Does

This Xano run job enables your application to:

1. **Send Transactional Emails** - Send single emails via the `/run/job` API endpoint with recipient, subject, and content
2. **Scheduled Health Checks** - Automatically sends daily system health check emails (configured in the scheduled task)

## API Provider

**Postmark** (https://postmarkapp.com) - A fast, reliable transactional email service used by companies like宜家 (IKEA), UNICEF, and more.

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `POSTMARK_API_KEY` | Your Postmark server API token | Yes |
| `POSTMARK_SENDER_EMAIL` | Default verified sender email address | Yes |
| `POSTMARK_ALERT_EMAIL` | Email address for health check alerts | No (for scheduled task) |

### Getting Your Postmark API Key

1. Sign up at https://postmarkapp.com
2. Create a server in your Postmark dashboard
3. Copy the **Server API Token** from your server settings
4. Verify your sender signature or domain in Postmark

## How to Use

### Send a Single Email

**Endpoint:** `POST /run/job`

**Request Body:**
```json
{
  "to": "recipient@example.com",
  "subject": "Welcome to Our Service!",
  "html_body": "<h1>Welcome!</h1><p>Thanks for joining us.</p>",
  "text_body": "Welcome! Thanks for joining us.",
  "tag": "welcome-email"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Email sent successfully",
  "message_id": "b7bc1c1e-5f8a-4a2b-9c3d-1e2f3a4b5c6d",
  "recipient": "recipient@example.com",
  "submitted_at": "2025-02-12T21:01:00.0000000Z"
}
```

### Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `to` | email | Yes | Recipient email address |
| `subject` | text | Yes | Email subject line |
| `html_body` | text | No* | HTML content of the email |
| `text_body` | text | No* | Plain text content of the email |
| `tag` | text | No | Tag for categorizing emails in Postmark |

\* At least one of `html_body` or `text_body` must be provided.

## File Structure

```
~/xs/postmark-send-email/
├── functions/
│   └── postmark_send_email.xs    # Reusable email sending function
├── tasks/
│   └── email_health_check.job.xs # Scheduled health check task
├── apis/
│   └── run.job.xs                # API endpoint for sending emails
└── README.md                     # This file
```

## Scheduled Task

The `email_health_check.job.xs` task runs daily and sends a system health status email to the configured alert recipient. It includes:

- System metrics (CPU, memory, disk usage)
- Uptime information
- Last backup timestamp

To modify the schedule, edit the `schedule` block in the task file.

## Error Handling

The run job handles common error scenarios:

- Missing API key or sender email configuration
- Invalid recipient email format
- Missing subject or body content
- Postmark API errors (returns descriptive error messages)

## Postmark Benefits

- **Fast Delivery**: Sub-second delivery times
- **Great Deliverability**: High inbox placement rates
- **Detailed Analytics**: Open, click, and bounce tracking
- **Tags**: Organize and filter emails by type
- **Templates**: Support for Postmark templates (can be extended)

## Support

For Postmark-specific issues, visit: https://postmarkapp.com/support
For XanoScript questions, refer to the Xano documentation.
