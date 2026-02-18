# Mailjet Send Email - Xano Run Job

This Xano Run Job sends emails using the Mailjet API. It demonstrates how to integrate with Mailjet's email delivery service from Xano.

## What This Run Job Does

The `Mailjet Send Email` run job sends transactional emails by:
1. Accepting email details (sender, recipient, subject, content)
2. Supporting both plain text and HTML email content
3. Making an authenticated request to Mailjet's `/v3.1/send` endpoint
4. Returning the send result with message IDs and delivery status

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `mailjet_api_key` | Your Mailjet API Key | `abc123...` |
| `mailjet_secret_key` | Your Mailjet Secret Key | `def456...` |

### Getting Your Mailjet API Credentials

1. Log in to your [Mailjet Dashboard](https://app.mailjet.com)
2. Go to Account Settings → API Key Management
3. Copy your **API Key** and **Secret Key**
4. For new accounts, you may need to generate a new API key pair

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Mailjet Send Email"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Mailjet Send Email"
}
```

### Customizing the Email

Edit the `input` block in `run.xs`:

```xs
run.job "Mailjet Send Email" {
  main = {
    name: "mailjet_send_email"
    input: {
      from_email: "notifications@yourcompany.com"
      from_name: "Your Company"
      to_email: "customer@example.com"
      to_name: "John Doe"
      subject: "Welcome to Your Company!"
      text_content: "Hi John, welcome to our platform! We're excited to have you."
      html_content: "<h1>Welcome!</h1><p>Hi <strong>John</strong>, welcome to our platform!</p>"
    }
  }
  env = ["mailjet_api_key", "mailjet_secret_key"]
}
```

### Send Text-Only Email

To send only plain text (no HTML), set `html_content` to an empty string:

```xs
input: {
  from_email: "sender@example.com"
  from_name: "Your Name"
  to_email: "recipient@example.com"
  to_name: "Recipient Name"
  subject: "Plain Text Email"
  text_content: "This is a plain text email."
  html_content: ""
}
```

## File Structure

```
mailjet-send-email/
├── run.xs                    # Run job configuration
├── function/
│   └── mailjet_send_email.xs # Function that calls Mailjet API
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Response Format

On success, the function returns a Mailjet send response:

```json
{
  "Messages": [
    {
      "Status": "success",
      "CustomID": "",
      "To": [
        {
          "Email": "recipient@example.com",
          "MessageUUID": "abc123-...",
          "MessageID": 123456789,
          "MessageHref": "https://api.mailjet.com/v3/REST/message/123456789"
        }
      ],
      "Cc": [],
      "Bcc": []
    }
  ]
}
```

## Error Handling

The function throws a `MailjetAPIError` if:
- The Mailjet API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key or secret)
- The sender email is not validated in Mailjet
- The recipient email is invalid

Common error status codes:
- `401 Unauthorized` - Invalid API credentials
- `403 Forbidden` - Sender email not validated
- `400 Bad Request` - Invalid request payload

## Security Notes

- **Never commit your Mailjet API keys** - always use environment variables
- Use separate API keys for development and production
- Validate sender email addresses in your Mailjet dashboard before sending
- Consider implementing rate limiting to prevent abuse
- Use HTTPS for all API communications (built into the function)

## Sender Email Validation

Before sending emails, you must validate your sender domain or email in Mailjet:

1. Go to Account Settings → Sender Addresses
2. Add and verify your sender email or domain
3. Unverified senders will result in 403 errors

## Additional Resources

- [Mailjet API Documentation](https://dev.mailjet.com/email/reference/overview/)
- [Mailjet Send API v3.1](https://dev.mailjet.com/email/reference/send-emails/)
- [Mailjet Dashboard](https://app.mailjet.com)
- [XanoScript Documentation](https://docs.xano.com)

## Pricing

Mailjet offers a free tier with:
- 6,000 emails per month (200 per day)
- Unlimited contacts
- Advanced email editor
- Basic statistics

Paid plans start at $15/month for higher volumes.
