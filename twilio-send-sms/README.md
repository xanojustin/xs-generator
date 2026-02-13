# Twilio Send SMS - Xano Run Job

This Xano Run Job sends SMS messages using the Twilio API.

## What It Does

The run job executes a function that sends an SMS message to a specified phone number using Twilio's messaging API.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `twilio_account_sid` | Your Twilio Account SID (starts with AC...) |
| `twilio_auth_token` | Your Twilio Auth Token (secret key) |
| `twilio_from_number` | Your Twilio phone number (e.g., +1234567890) |

## How to Use

1. Set up your environment variables in the Xano dashboard or your `.env` file
2. Run the job with your desired phone number and message:

```bash
# Default values are set in run.xs, but you can override them
# by modifying the input block in run.xs
```

### Modifying Input Parameters

Edit the `run.xs` file to change the default input:

```xs
run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {
      to_phone: "+1987654321"  // Your target phone number
      message: "Your custom message here!"
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token", "twilio_from_number"]
}
```

## API Reference

The function uses Twilio's REST API:
- **Endpoint**: `POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages.json`
- **Authentication**: Basic Auth (AccountSid:AuthToken)
- **Parameters**:
  - `To`: Destination phone number (E.164 format)
  - `From`: Your Twilio phone number
  - `Body`: The message text

## File Structure

```
twilio-send-sms/
├── run.xs           # Run job configuration
├── function/
│   └── send_sms.xs  # SMS sending function
└── README.md        # This file
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "sid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "queued",
  "to": "+1234567890",
  "from": "+1987654321",
  "body": "Hello from XanoScript!"
}
```

## Error Handling

The function validates inputs and handles API errors:
- Missing phone number or message returns input error
- Twilio API errors are caught and thrown with descriptive messages

## Getting Twilio Credentials

1. Sign up at [twilio.com](https://www.twilio.com)
2. Get your Account SID and Auth Token from the [Console](https://console.twilio.com)
3. Buy a phone number or use your existing Twilio number
