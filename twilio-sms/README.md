# Twilio SMS Sender

A XanoScript run job that sends SMS messages via the Twilio API and logs all attempts to a database table.

## What This Run Job Does

This job sends transactional SMS messages using Twilio's REST API. It:

1. Validates the phone number format (E.164)
2. Validates the message length (max 1600 characters)
3. Sends the SMS via Twilio's Messages API
4. Logs the result (success or failure) to the `sms_log` table
5. Returns the message SID and status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `twilio_account_sid` | Your Twilio Account SID (starts with AC...) |
| `twilio_auth_token` | Your Twilio Auth Token |
| `twilio_phone_number` | Your Twilio phone number (E.164 format, e.g., +1234567890) |

## Files Structure

```
twilio-sms/
├── run.xs              # Run job configuration
├── functions/
│   └── send_sms.xs     # Main SMS sending function
├── tables/
│   └── sms_log.xs      # Database table for logging
└── README.md           # This file
```

## How to Use

### Running the Job

```bash
# Via Xano CLI
xano run run.xs

# Or with custom input
xano run run.xs --input '{"to": "+15555555555", "message": "Custom message"}'
```

### Using the Function Directly

You can also call the `send_sms` function from other Xano APIs:

```xs
# In another function or API
function "notify_user" {
  input {
    int user_id
    text message
  }
  stack {
    # Get user's phone number from your users table
    db.query users {
      where = $db.users.id == $input.user_id
      return = { type: "one" }
    } as $user
    
    # Call the send_sms function
    call send_sms {
      to: $user.phone_number
      message: $input.message
    } as $result
  }
  response = $result
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | text | Yes | Recipient phone number in E.164 format (e.g., +1234567890) |
| `message` | text | Yes | The SMS message body (max 1600 characters) |

### Response

**Success:**
```json
{
  "success": true,
  "message_sid": "SM1234567890abcdef...",
  "status": "queued",
  "to": "+1234567890",
  "logged_id": 42
}
```

**Failure:**
```json
{
  "success": false,
  "error": "The 'To' number is not a valid phone number.",
  "error_code": "21211",
  "status_code": 400,
  "logged_id": 43
}
```

## Database Table: sms_log

All SMS attempts are logged with:

- `to_number`: Recipient phone number
- `from_number`: Sender phone number (your Twilio number)
- `message_body`: The message content
- `status`: Delivery status (queued, sent, delivered, failed, etc.)
- `twilio_sid`: Twilio's message SID (unique identifier)
- `sent_at`: Timestamp of the attempt
- `error_code`: Twilio error code (if failed)
- `error_message`: Error description (if failed)

## Twilio Resources

- [Twilio Console](https://www.twilio.com/console)
- [Twilio SMS API Docs](https://www.twilio.com/docs/sms/api/message-resource)
- [Twilio Error Codes](https://www.twilio.com/docs/api/errors)
- [E.164 Phone Number Format](https://www.twilio.com/docs/glossary/what-e164)

## Security Notes

- Never commit your Twilio credentials to version control
- Use environment variables for all sensitive data
- Consider implementing rate limiting to prevent abuse
- Add phone number validation before calling this function
