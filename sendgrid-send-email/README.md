# SendGrid Email Send Run Job

A XanoScript run job that sends emails using the SendGrid API.

## What It Does

This run job sends transactional emails via SendGrid's REST API. It supports both plain text and HTML email content.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `sendgrid_api_key` | Your SendGrid API key (starts with `SG.`) |

Get your API key from: https://app.sendgrid.com/settings/api_keys

## How to Use

### 1. Set the Environment Variable

```bash
export sendgrid_api_key="SG.your_api_key_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Email

Edit the `input` block in `run.xs` to customize:

```xs
run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "customer@example.com"
      from: "noreply@yourdomain.com"
      subject: "Welcome to Our Service!"
      text: "Plain text version of your message"
      html: "<h1>HTML version</h1><p>With formatting!</p>"
    }
  }
  env = ["sendgrid_api_key"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | email | Yes | Recipient email address |
| `from` | email | Yes | Sender email address (must be verified in SendGrid) |
| `subject` | text | Yes | Email subject line |
| `text` | text | Yes | Plain text email body |
| `html` | text | No | HTML email body (optional) |

## File Structure

```
sendgrid-send-email/
├── run.xs                    # Run job configuration
├── functions/
│   └── send_email.xs         # Function that calls SendGrid API
└── README.md                 # This file
```

## API Reference

This implementation uses the SendGrid v3 Mail Send API:
- Endpoint: `POST https://api.sendgrid.com/v3/mail/send`
- Documentation: https://docs.sendgrid.com/api-reference/mail-send/mail-send

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (to, from, subject)
- Invalid email formats
- SendGrid API errors

## License

MIT
