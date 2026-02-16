# Twilio SMS Run Job

This Xano Run Job sends SMS messages using the Twilio API.

## What It Does

The `send_sms` function makes an authenticated request to Twilio's Programmable SMS API to send text messages to any valid phone number worldwide.

## Prerequisites

1. A [Twilio account](https://www.twilio.com/try-twilio)
2. A Twilio phone number with SMS capabilities
3. Your Account SID and Auth Token from the Twilio Console

## Required Environment Variables

Set these in your Xano workspace environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `twilio_account_sid` | Your Twilio Account SID | `ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` |
| `twilio_auth_token` | Your Twilio Auth Token | `your_auth_token_here` |
| `twilio_phone_number` | Your Twilio phone number (E.164 format) | `+1234567890` |

## File Structure

```
twilio-send-sms/
├── run.xs              # Run job configuration
├── function/
│   └── send_sms.xs     # SMS sending function
└── README.md           # This file
```

## Usage

### Running the Job

The job is configured with default values in `run.xs`:

```xs
run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1234567890"
      message: "Hello from Xano!"
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token", "twilio_phone_number"]
}
```

Update the `input` values in `run.xs` or pass them when executing.

### Function Parameters

The `send_sms` function accepts:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_number` | text | Yes | Recipient phone number in E.164 format (e.g., +1234567890) |
| `message` | text | Yes | The message body to send |

### Response

On success, returns:

```json
{
  "success": true,
  "message_sid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "queued",
  "to": "+1234567890",
  "from": "+1987654321",
  "message": "SMS sent successfully"
}
```

## Error Handling

The function handles common Twilio API errors:

- **400 Bad Request**: Invalid phone number or malformed request
- **401 Unauthorized**: Invalid credentials
- **404 Not Found**: Invalid Account SID
- **Other errors**: Generic API error messages

## Phone Number Format

Phone numbers must be in [E.164 format](https://www.twilio.com/docs/glossary/what-e164):
- Start with `+`
- Followed by country code
- Then the phone number
- No spaces or special characters

Examples:
- US: `+1234567890`
- UK: `+447123456789`
- Australia: `+61412345678`

## Security Notes

- Never commit your Twilio Auth Token to version control
- Use Xano environment variables for all sensitive credentials
- The Auth Token is base64 encoded for Basic Auth (as required by Twilio)

## Twilio Documentation

- [Twilio SMS API](https://www.twilio.com/docs/sms/api)
- [Twilio Console](https://console.twilio.com/)
