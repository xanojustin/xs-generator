# SendGrid Email Sender Run Job

A XanoScript run job that sends emails using the SendGrid API.

## What This Run Job Does

This run job demonstrates how to integrate with the SendGrid email API to send transactional emails. It includes a function that sends a welcome email to new users with both plain text and HTML content.

## Files Structure

```
~/xs/sendgrid-email/
├── run.xs                          # Run job configuration
├── functions/
│   └── send_welcome_email.xs      # Email sending function
└── README.md                       # This file
```

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `sendgrid_api_key` | Your SendGrid API key | `SG.xxx...` |
| `sendgrid_from_email` | The verified sender email address | `noreply@example.com` |
| `sendgrid_from_name` | The display name for the sender | `My App Team` |

## How to Set Environment Variables

In Xano, go to **Settings → Environment Variables** and add:

```
sendgrid_api_key=SG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
sendgrid_from_email=noreply@yourdomain.com
sendgrid_from_name=Your App Name
```

## Usage

### Running the Job

```bash
# Via Xano Job Runner
xano job run sendgrid-email

# Or trigger via API
POST /_job/sendgrid-email
```

### Default Input Parameters

The run.job is configured with these default inputs:

| Parameter | Type | Default Value |
|-----------|------|---------------|
| `to_email` | email | `user@example.com` |
| `to_name` | text | `New User` |
| `subject` | text | `Welcome to our platform!` |
| `message` | text | `Thank you for signing up...` |

### Customizing Input

You can override the default inputs when running the job:

```json
{
  "to_email": "john@example.com",
  "to_name": "John Doe",
  "subject": "Your account is ready!",
  "message": "Welcome to our service, John!"
}
```

## SendGrid Setup

1. Sign up for a SendGrid account at https://sendgrid.com
2. Create an API key with "Mail Send" permissions
3. Verify your sender email address or domain in SendGrid
4. Add the API key and sender details to your Xano environment variables

## API Reference

This integration uses the SendGrid v3 Mail Send API:
- Documentation: https://docs.sendgrid.com/api-reference/mail-send/mail-send
- Endpoint: `POST https://api.sendgrid.com/v3/mail/send`

## Response Format

### Success Response

```json
{
  "success": true,
  "message": "Email sent successfully",
  "to": "user@example.com",
  "status_code": 202
}
```

### Error Response

```json
{
  "success": false,
  "message": "Failed to send email",
  "to": "user@example.com",
  "status_code": 400,
  "error": { ... }
}
```

## Extending This Job

You can extend this function to:
- Add attachments to emails
- Use SendGrid templates with dynamic data
- Send batch emails to multiple recipients
- Track email opens and clicks via webhooks
- Add categories for analytics

## License

MIT - Feel free to use and modify as needed.
