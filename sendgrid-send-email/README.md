# SendGrid Send Email - Xano Run Job

This Xano Run Job sends emails using the [SendGrid](https://sendgrid.com) API and logs the sent emails to a database table.

## What It Does

1. Accepts email parameters (to, from, subject, body)
2. Sends the email via SendGrid's v3 Mail Send API
3. Logs the sent email to the `email_log` table
4. Returns success status and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SENDGRID_API_KEY` | Your SendGrid API key (get from https://app.sendgrid.com/settings/api_keys) |

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "SendGrid Send Email"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "your@email.com"
      subject: "Custom Subject"
      body: "<h1>HTML Content</h1>"
      from: "your-verified@domain.com"
    }
  }
  env = ["SENDGRID_API_KEY"]
}
```

### Function Inputs

The `send_email` function accepts:

| Input | Type | Required | Description |
|-------|------|----------|-------------|
| `to` | text | Yes | Recipient email address |
| `from` | text | Yes | Sender email address (must be verified in SendGrid) |
| `subject` | text | Yes | Email subject line |
| `body` | text | Yes | HTML email body |

### Response

```json
{
  "success": true,
  "recipient": "recipient@example.com",
  "logged_id": 1
}
```

## Files

- `run.xs` - Run job configuration
- `function/send_email.xs` - Email sending logic
- `table/email_log.xs` - Database table for logging sent emails

## Notes

- The `from` email must be a verified sender in your SendGrid account
- SendGrid's free tier allows 100 emails per day
- Emails are logged to the `email_log` table for tracking
- SendGrid returns a 202 Accepted status on successful submission
