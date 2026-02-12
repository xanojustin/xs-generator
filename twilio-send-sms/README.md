# Twilio Send SMS Run Job

A XanoScript run job that sends SMS messages using the Twilio API.

## What It Does

This run job sends SMS (text messages) and MMS (media messages) via Twilio's REST API. Perfect for:

- Transactional notifications (order confirmations, shipping updates)
- Two-factor authentication codes
- Appointment reminders
- Marketing messages (with opt-in compliance)
- Alert systems

Supports both plain text SMS and MMS with media attachments.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `twilio_account_sid` | Your Twilio Account SID (starts with `AC...`) |
| `twilio_auth_token` | Your Twilio Auth Token |

Get your credentials from: https://www.twilio.com/console

**Security Note:** Keep these credentials secure. Never commit them to version control.

## How to Use

### 1. Set the Environment Variables

```bash
export twilio_account_sid="ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export twilio_auth_token="your_auth_token_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Message

Edit the `input` block in `run.xs` to customize:

```xs
run.job "Twilio Send SMS" {
  main = {
    name: "twilio_send_sms"
    input: {
      to: "+14155551234"
      from_number: "+15005550006"
      body: "Your appointment is confirmed for tomorrow at 2pm."
      media_url: "https://example.com/image.png"  // Optional: for MMS
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | text | Yes | Recipient phone number in E.164 format (e.g., `+14155551234`) |
| `from_number` | text | Yes | Sender Twilio phone number in E.164 format |
| `body` | text | Yes | Message text (max 1600 characters for SMS) |
| `media_url` | text | No | URL of media attachment (optional, converts to MMS) |

### Phone Number Format

Use E.164 format: `+` followed by country code and phone number.
- US/Canada: `+14155551234`
- UK: `+447700900123`
- Australia: `+61412345678`

### Test Phone Numbers

Twilio provides test credentials that don't charge or send real messages:
- `+15005550001` - Valid US number
- `+15005550006` - Valid number with messaging enabled
- `+15005550000` - Invalid number (triggers error for testing)

Full list: https://www.twilio.com/docs/iam/test-credentials

## File Structure

```
twilio-send-sms/
├── run.xs                          # Run job configuration
├── functions/
│   └── twilio_send_sms.xs          # Function that calls Twilio API
└── README.md                       # This file
```

## API Reference

This implementation uses the Twilio Programmable Messaging API:
- Endpoint: `POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages.json`
- Documentation: https://www.twilio.com/docs/sms/api/message-resource

## Response

On success, the function returns:

```json
{
  "success": true,
  "message_sid": "SM1234567890abcdef1234567890abcdef",
  "to": "+14155551234",
  "from": "+15005550006",
  "body": "Hello from Xano!",
  "status": "queued",
  "direction": "outbound-api",
  "date_created": "Thu, 12 Feb 2026 21:52:00 +0000",
  "num_segments": 1,
  "price": null
}
```

### Status Values

| Status | Description |
|--------|-------------|
| `queued` | Message is queued for sending |
| `sending` | Message is being sent |
| `sent` | Message has been sent |
| `delivered` | Message was delivered (with delivery receipts enabled) |
| `failed` | Message failed to send |

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (to, from, body)
- Invalid phone number formats
- Twilio API errors (invalid credentials, insufficient balance, invalid numbers)

## Pricing

Twilio charges per message sent:
- SMS: Varies by destination country
- MMS: Higher rate than SMS
- Check current pricing: https://www.twilio.com/sms/pricing

## License

MIT
