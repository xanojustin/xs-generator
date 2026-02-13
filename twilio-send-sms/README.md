# Twilio Send SMS - Xano Run Job

This Xano run job sends SMS messages using the Twilio API.

## What It Does

The run job executes a function that sends an SMS message from your Twilio phone number to a specified recipient. It handles:

- Authentication with Twilio using Account SID and Auth Token
- Formatting the API request with proper headers
- Sending the SMS via Twilio's Messages API
- Returning success/error status with response details

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `twilio_account_sid` | Your Twilio Account SID (starts with AC...) | `ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` |
| `twilio_auth_token` | Your Twilio Auth Token | `your_auth_token_here` |
| `twilio_from_number` | Your Twilio phone number (E.164 format) | `+1234567890` |
| `twilio_to_number` | Recipient phone number (E.164 format) | `+1987654321` |

## Optional Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `twilio_message_body` | Custom message content | `"Hello from Xano! This is a test SMS sent via Twilio."` |

## How to Use

### 1. Set Environment Variables

Configure the required environment variables in your Xano workspace settings.

### 2. Run the Job

Execute the run job using the Xano CLI or dashboard:

```bash
xano run execute twilio-send-sms
```

### 3. Customize the Message

Set the `twilio_message_body` environment variable to customize the message, or edit `function/send_sms.xs` to change the default message.

## File Structure

```
twilio-send-sms/
├── run.xs              # Run job configuration
├── function/
│   └── send_sms.xs     # SMS sending function
├── README.md           # This file
└── FEEDBACK.md         # Development feedback for MCP improvements
```

## Twilio API Reference

- **Endpoint**: `POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages.json`
- **Auth**: Basic Auth (AccountSid:AuthToken, Base64 encoded)
- **Parameters**:
  - `To`: Recipient phone number (E.164 format)
  - `From`: Your Twilio phone number (E.164 format)
  - `Body`: Message content (max 1600 characters)

## Response Format

```json
{
  "status": "success",
  "message": "SMS sent successfully. SID: SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "twilio_response": {
    "sid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "date_created": "Fri, 13 Feb 2026 17:45:00 +0000",
    "date_updated": "Fri, 13 Feb 2026 17:45:00 +0000",
    "date_sent": null,
    "account_sid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "to": "+1987654321",
    "from": "+1234567890",
    "messaging_service_sid": null,
    "body": "Hello from Xano! This is a test SMS sent via Twilio.",
    "status": "queued",
    "num_segments": "1",
    "num_media": "0",
    "direction": "outbound-api",
    "api_version": "2010-04-01",
    "price": null,
    "price_unit": "USD",
    "error_code": null,
    "error_message": null,
    "uri": "/2010-04-01/Accounts/ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/Messages/SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.json"
  }
}
```

## Error Handling

If the SMS fails to send, the response will include:

```json
{
  "status": "error",
  "message": "Failed to send SMS. Status: 400, Error: The 'To' number is not a valid phone number.",
  "twilio_response": { ... }
}
```

## Notes

- Phone numbers must be in E.164 format (e.g., `+1234567890`)
- Twilio trial accounts can only send to verified numbers
- Standard SMS rates apply based on your Twilio pricing plan
