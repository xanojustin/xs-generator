# Mailgun Send Email Run Job

A Xano Run Job that sends transactional emails using the Mailgun API.

## What It Does

This run job sends an email via Mailgun's transactional email API. It's useful for:
- Sending notifications
- Welcome emails
- Password resets
- Any transactional email needs

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `MAILGUN_API_KEY` | Your Mailgun API key (starts with "key-") | `key-xxxxxxxxxxxxxxxx` |
| `MAILGUN_DOMAIN` | Your verified Mailgun domain | `mg.example.com` |
| `MAILGUN_FROM_EMAIL` | The sender email address | `noreply@example.com` |

## How to Use

### 1. Set Up Mailgun

1. Sign up for a Mailgun account at https://www.mailgun.com
2. Verify your domain in the Mailgun dashboard
3. Copy your API key from the dashboard

### 2. Configure Environment Variables

Set the three required environment variables in your Xano workspace.

### 3. Customize the Run Job

Edit `run.xs` to customize the email parameters:

```xs
run.job "Send Email via Mailgun" {
  main = {
    name: "send_email"
    input: {
      to: "user@example.com"           // Recipient email
      subject: "Your Subject Here"      // Email subject
      body: "Your message here..."      // Email body (plain text)
      from_name: "Your App Name"        // Sender display name
    }
  }
  env = ["MAILGUN_API_KEY", "MAILGUN_DOMAIN", "MAILGUN_FROM_EMAIL"]
}
```

### 4. Run the Job

Use the Xano CLI or dashboard to execute the run job.

## File Structure

```
mailgun-send-email/
├── run.xs              # Run job configuration
├── function/
│   └── send_email.xs   # Function that calls Mailgun API
└── README.md           # This file
```

## API Reference

This run job uses the Mailgun Messages API:
- **Endpoint**: `POST https://api.mailgun.net/v3/{domain}/messages`
- **Authentication**: HTTP Basic Auth (username: "api", password: API key)
- **Content-Type**: `application/x-www-form-urlencoded`

## Response

On success, the function returns:
```json
{
  "success": true,
  "message_id": "<20240216120000.123456789@mg.example.com>",
  "message": "Email sent successfully"
}
```

## Error Handling

The function handles common error cases:
- **401**: Invalid API key
- **404**: Domain not found
- **Other**: Returns detailed error message from Mailgun

## Customization Ideas

- Add HTML email support by adding an `html` parameter
- Add CC/BCC support
- Add attachment support
- Add batch email sending for multiple recipients
- Store email logs in a database table

## Links

- [Mailgun Documentation](https://documentation.mailgun.com/)
- [Mailgun API Reference](https://documentation.mailgun.com/en/latest/api-sending.html)
