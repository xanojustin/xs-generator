# Twilio Verify Phone Run Job

This XanoScript run job provides phone number verification using the Twilio Verify API. It supports sending verification codes via SMS, voice calls, email, or WhatsApp, and verifying those codes.

## What It Does

This run job integrates with Twilio's Verify API to:

1. **Start Verification** (`start_verification`): Send a verification code to a phone number via your chosen channel
2. **Check Verification** (`check_verification`): Verify that a code entered by the user is correct

Use cases include:
- Phone number verification during user registration
- Two-factor authentication (2FA)
- Passwordless login
- Transaction verification

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `twilio_account_sid` | Your Twilio Account SID (starts with `AC`) |
| `twilio_auth_token` | Your Twilio Auth Token (found in Twilio Console) |

## How to Use

### Setup in Twilio Console

1. Create a Verify Service in your [Twilio Console](https://www.twilio.com/console/verify/services)
2. Copy the Service SID (starts with `VA`)
3. Configure your environment variables with your Account SID and Auth Token

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Start Verification Function

**Input Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_phone` | text | Yes | Phone number in E.164 format (e.g., `+1234567890`) |
| `channel` | text | No | Channel to use: `sms`, `call`, `email`, or `whatsapp` (default: `sms`) |
| `service_sid` | text | Yes | Twilio Verify Service SID (e.g., `VAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`) |

**Response:**

```json
{
  "success": true,
  "sid": "VExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "pending",
  "valid": true,
  "error": null
}
```

### Check Verification Function

**Input Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_phone` | text | Yes | Phone number being verified (E.164 format) |
| `code` | text | Yes | The verification code entered by the user |
| `service_sid` | text | Yes | Twilio Verify Service SID |

**Response (Success):**

```json
{
  "success": true,
  "sid": "VExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "approved",
  "valid": true,
  "error": null
}
```

**Response (Invalid Code):**

```json
{
  "success": true,
  "sid": null,
  "status": "pending",
  "valid": false,
  "error": null
}
```

**Response (Error):**

```json
{
  "success": false,
  "sid": null,
  "status": null,
  "valid": false,
  "error": "Verification check failed"
}
```

## File Structure

```
twilio-verify-phone/
├── run.xs                           # Run job definition
├── function/
│   ├── start_verification.xs        # Function to start verification
│   └── check_verification.xs        # Function to check verification code
└── README.md                        # This file
```

## Twilio Verify API Reference

- [Twilio Verify API Documentation](https://www.twilio.com/docs/verify/api)
- [Verification Resource](https://www.twilio.com/docs/verify/api/verification)
- [Verification Check Resource](https://www.twilio.com/docs/verify/api/verification-check)

## Supported Channels

| Channel | Description |
|---------|-------------|
| `sms` | SMS text message (default) |
| `call` | Automated voice call |
| `email` | Email (requires email configuration in Verify Service) |
| `whatsapp` | WhatsApp message |

## Security Notes

- Never commit your `twilio_auth_token` to version control
- Use Twilio's test credentials during development
- Store your Service SID securely - it should not be exposed to clients
- Consider rate limiting verification attempts to prevent abuse
- Implement a maximum number of verification attempts per phone number

## Testing

For testing without using real SMS:
1. Use Twilio's [Magic Numbers](https://www.twilio.com/docs/verify/api#magic-numbers) that always pass verification
2. Or use the `000000` code when using test credentials (check Twilio documentation for current test codes)

## Rate Limits

Twilio Verify has rate limits based on your plan. Be aware of:
- Maximum verification attempts per phone number
- Maximum verifications per second
- Geographic restrictions

See [Twilio Verify Rate Limits](https://www.twilio.com/docs/verify/api#rate-limits) for details.