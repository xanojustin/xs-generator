# Mailgun Send Email - Xano Run Job

This Xano Run Job sends emails using the [Mailgun](https://www.mailgun.com) API and logs the sent emails to a database table.

## What It Does

1. Accepts email parameters (to, from, subject, body)
2. Extracts the domain from the sender email for the Mailgun API endpoint
3. Sends the email via Mailgun's REST API using Basic Auth
4. Logs the sent email to the `email_log` table
5. Returns the message ID and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MAILGUN_API_KEY` | Your Mailgun API key (get from https://app.mailgun.com/app/account/security/api_keys) |

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "Mailgun Send Email"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Mailgun Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "your@email.com"
      subject: "Custom Subject"
      body: "<h1>HTML Content</h1>"
      from: "your-verified@your-domain.com"
    }
  }
  env = ["MAILGUN_API_KEY"]
}
```

### Function Inputs

The `send_email` function accepts:

| Input | Type | Required | Description |
|-------|------|----------|-------------|
| `to` | text | Yes | Recipient email address |
| `from` | text | Yes | Sender email address (must be a verified domain in Mailgun) |
| `subject` | text | Yes | Email subject line |
| `body` | text | Yes | HTML email body |

### Response

```json
{
  "success": true,
  "message_id": "<message-id@your-domain.com>",
  "recipient": "recipient@example.com",
  "logged_id": 1
}
```

## Files

- `run.xs` - Run job configuration
- `function/send_email.xs` - Email sending logic
- `table/email_log.xs` - Database table for logging sent emails

## Notes

- The `from` email domain must be a verified domain in your Mailgun account
- Mailgun uses Basic Auth with `api:` as the username and your API key as the password
- The domain is extracted from the `from` email address to construct the API URL
- Emails are logged to the `email_log` table for tracking
- Mailgun's sandbox domains can only send to authorized recipients
