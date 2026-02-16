# SendGrid Email Run Job

A Xano Run Job that demonstrates sending transactional emails via the SendGrid API.

## What This Run Job Does

This run job performs the following operations:

1. **Validates Email Format** - Checks that the recipient email address is properly formatted
2. **Builds Email Payload** - Constructs the SendGrid API payload with personalization, from, subject, and content
3. **Sends via SendGrid API** - Makes an authenticated request to SendGrid's v3 Mail Send API
4. **Logs the Result** - Saves email details to a local database table (if available)
5. **Returns Status** - Provides confirmation of successful send with timestamp

## Use Cases

- Welcome emails for new user registration
- Password reset notifications
- Order confirmations and receipts
- Marketing campaign emails
- Alert and notification systems
- Email verification workflows

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `sendgrid_api_key` | Your SendGrid API Key | Get from SendGrid Dashboard → Settings → API Keys |

## File Structure

```
~/xs/sendgrid-email/
├── run.xs                          # Run job configuration
├── function/
│   ├── send_email.xs               # Main function to send emails
│   └── validate_email.xs           # Helper to validate email format
└── README.md                       # This file
```

## How to Use

### 1. Set Up Environment Variables

In your Xano workspace settings, add:
- `sendgrid_api_key` = `SG.xxxxx...` (your SendGrid API key)

### 2. Configure Sender Authentication

In SendGrid Dashboard:
- Go to Settings → Sender Authentication
- Verify your sender domain or add a single sender verification
- Use verified `from_email` addresses only

### 3. Run the Job

```bash
# Via Xano CLI or dashboard
xano run start sendgrid-email
```

### 4. Customize the Input

Edit `run.xs` to change the email parameters:

```xs
run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "user@example.com"
      to_name: "John Doe"
      from_email: "noreply@yourdomain.com"
      from_name: "Your App"
      subject: "Welcome to Our App!"
      body_text: "Plain text version of the email"
      body_html: "<h1>Welcome!</h1><p>HTML version...</p>"
    }
  }
  env = ["sendgrid_api_key"]
}
```

### 5. Optional: Add Email Log Table

To store sent email records locally, create a table named `email_log` with these fields:
- `id` (int, primary key)
- `to_email` (text)
- `to_name` (text)
- `from_email` (text)
- `subject` (text)
- `status` (text)
- `sent_at` (timestamp)

## Response Format

```json
{
  "success": true,
  "message": "Email sent successfully",
  "to_email": "recipient@example.com",
  "subject": "Test Email from Xano",
  "sent_at": "2024-01-15T10:30:00Z"
}
```

## Email Content Options

The run job supports both plain text and HTML content:

- **body_text** (required) - Plain text version of the email
- **body_html** (optional) - HTML version for rich formatting

If both are provided, email clients will display the HTML version when supported.

## Important Notes

- **API Key Security** - Never commit your SendGrid API key to version control
- **Sender Verification** - SendGrid requires sender authentication before sending
- **Rate Limits** - SendGrid has rate limits based on your plan (100 emails/day on free tier)
- **Spam Compliance** - Ensure you comply with CAN-SPAM, GDPR, and other regulations
- **Webhook Handling** - For production, set up SendGrid webhooks to track delivery, opens, and clicks

## SendGrid API Reference

- [Mail Send API v3](https://docs.sendgrid.com/api-reference/mail-send/mail-send)
- [API Keys](https://docs.sendgrid.com/ui/account-and-settings/api-keys)
- [Sender Authentication](https://docs.sendgrid.com/ui/account-and-settings/sender-authentication)

## Error Handling

The run job includes validation and error handling for:
- Invalid email format
- SendGrid API failures
- Missing required fields
- Network timeouts

## Security Considerations

- Use environment variables for all secrets
- Restrict API key permissions to only Mail Send
- Enable 2FA on your SendGrid account
- Monitor email sending for suspicious activity
- Validate and sanitize all user input
