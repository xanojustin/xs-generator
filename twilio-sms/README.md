# Twilio SMS Run Job

A Xano Run Job that sends SMS messages using the Twilio API. Supports both SMS and MMS (with media URLs).

## What It Does

This run job sends text messages via Twilio's Programmable Messaging API. It can be used for:

- Sending transactional SMS notifications
- Sending marketing/promotional messages
- Two-factor authentication (2FA) codes
- Appointment reminders
- Order confirmations
- MMS messages with media attachments

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `TWILIO_ACCOUNT_SID` | Your Twilio Account SID | [Twilio Console](https://console.twilio.com) → Account Info |
| `TWILIO_AUTH_TOKEN` | Your Twilio Auth Token | [Twilio Console](https://console.twilio.com) → Account Info |

## How to Use

### 1. Set Up Environment Variables

Set these in your Xano workspace environment variables:

```
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 2. Get a Twilio Phone Number

Purchase a phone number from the [Twilio Console](https://console.twilio.com) → Phone Numbers → Manage → Buy a number.

### 3. Run the Job

The run job executes the `send_sms` function with the configured input parameters.

### 4. Customize the Input

Edit `run.xs` to change the message parameters:

```xs
run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1234567890"      // Recipient's phone number (E.164 format)
      from_number: "+1987654321"    // Your Twilio phone number (E.164 format)
      message_body: "Your custom message here"
      media_urls: [                  // Optional: for MMS
        "https://example.com/image.jpg"
      ]
    }
  }
  env = ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_number` | text | Yes | Recipient phone number in E.164 format (e.g., +1234567890) |
| `from_number` | text | Yes | Your Twilio phone number in E.164 format |
| `message_body` | text | Yes | The message text (max 1600 characters for SMS) |
| `media_urls` | text[] | No | Optional array of media URLs for MMS messages |

## Response

On success, the function returns:

```json
{
  "success": true,
  "message_sid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "queued",
  "to": "+1234567890",
  "from": "+1987654321",
  "body": "Hello from Xano Run Job!",
  "date_created": "Mon, 16 Feb 2026 09:15:00 +0000",
  "uri": "/2010-04-01/Accounts/ACxxx/Messages/SMxxx.json"
}
```

## Error Handling

The function validates inputs and environment variables before making the API call. Common errors:

- **Missing credentials**: Ensure `TWILIO_ACCOUNT_SID` and `TWILIO_AUTH_TOKEN` are set
- **Invalid phone number**: Use E.164 format (+1234567890)
- **Unverified number**: For trial accounts, verify the recipient number first
- **Insufficient balance**: Check your Twilio account balance

## File Structure

```
twilio-sms/
├── run.xs              # Run job definition
├── function/
│   └── send_sms.xs     # SMS sending function
└── README.md           # This file
```

## API Reference

- [Twilio Messages API](https://www.twilio.com/docs/sms/api/message-resource)
- [Twilio E.164 Format](https://www.twilio.com/docs/glossary/what-e164)

## Testing

Test with a verified phone number (required for Twilio trial accounts):

```xs
run.job "Send Test SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1234567890"
      from_number: "+1987654321"
      message_body: "Test message from Xano!"
    }
  }
  env = ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN"]
}
```

## Notes

- Phone numbers must be in E.164 format (+country code + number)
- For trial accounts, you can only send to verified phone numbers
- Standard SMS rates apply based on your Twilio pricing plan
- MMS requires the `media_urls` parameter with valid image URLs
