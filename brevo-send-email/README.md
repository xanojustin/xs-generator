# Brevo Send Email Run Job

This XanoScript run job sends transactional emails using the Brevo (formerly Sendinblue) API.

## What It Does

This run job sends emails via Brevo's SMTP API. It handles:

- Sending HTML and plain text emails
- Custom sender name and email (must be verified in Brevo)
- Recipient personalization with name
- Proper error handling with detailed messages
- Returns the Brevo message ID for tracking

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `BREVO_API_KEY` | Your Brevo API key (found in Brevo Dashboard → SMTP & API → API Keys) |

## How to Use

### Setup in Brevo

1. Sign up at [brevo.com](https://www.brevo.com)
2. Go to SMTP & API → API Keys
3. Create a new API key with appropriate permissions
4. Verify your sender domain in Brevo (required for production)

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | text | Yes | Recipient email address |
| `to_name` | text | No | Recipient name (for personalization) |
| `from_email` | text | Yes | Sender email address (must be verified in Brevo) |
| `from_name` | text | No | Sender display name (e.g., "Your App") |
| `subject` | text | Yes | Email subject line |
| `html_content` | text | Yes | HTML content of the email |
| `text_content` | text | No | Plain text version (recommended for deliverability) |

### Response

```json
{
  "success": true,
  "message_id": "<message-id@brevo.com>",
  "to_email": "recipient@example.com",
  "subject": "Test Email from XanoScript"
}
```

### Error Response

```json
{
  "success": false,
  "message_id": null,
  "to_email": "recipient@example.com",
  "subject": "Test Email from XanoScript"
}
```

## File Structure

```
brevo-send-email/
├── run.xs                    # Run job definition with test inputs
├── function/
│   └── send_email.xs         # Function to send email via Brevo API
└── README.md                 # This file
```

## Brevo API Reference

- [Brevo SMTP API Documentation](https://developers.brevo.com/reference/sendtransacemail)
- [API Rate Limits](https://developers.brevo.com/docs/api-limits)
- [Sender Verification](https://help.brevo.com/hc/en-us/articles/209462226)

## Testing

Use Brevo's free tier for testing (300 emails/day). Make sure to:
1. Use a verified sender email address
2. Test with your own email first
3. Check the Brevo dashboard for delivery status

## Security Notes

- Never commit your `BREVO_API_KEY` to version control
- Use Brevo's sandbox/testing mode during development
- Verify your sender domain before sending to customers
- The API key should have restricted permissions (send_email only)

## Common Issues

| Issue | Solution |
|-------|----------|
| "Invalid sender email" | Verify the sender email in Brevo Dashboard |
| "Unauthorized" | Check your API key is correct and active |
| "Rate limit exceeded" | Brevo free tier allows 300 emails/day |
| Emails going to spam | Add SPF/DKIM records for your domain |
