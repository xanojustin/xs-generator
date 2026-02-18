# Twilio Send SMS - Xano Run Job

This Xano Run Job sends SMS messages using the [Twilio](https://twilio.com) API and logs the results to a database table.

## What It Does

1. Accepts SMS parameters (recipient number, message body, optional sender number)
2. Sends the SMS via Twilio's REST API
3. Logs the message to the `sms_log` table
4. Returns the message SID and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `TWILIO_ACCOUNT_SID` | Your Twilio Account SID (get from https://console.twilio.com) |
| `TWILIO_AUTH_TOKEN` | Your Twilio Auth Token (get from https://console.twilio.com) |
| `TWILIO_PHONE_NUMBER` | Your default Twilio phone number (E.164 format, e.g., +1234567890) |

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "Twilio Send SMS"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Twilio Send SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1987654321"
      message_body: "Your verification code is 123456"
      from_number: ""  // Uses TWILIO_PHONE_NUMBER if empty
    }
  }
  env = ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN", "TWILIO_PHONE_NUMBER"]
}
```

### Function Inputs

The `send_sms` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `to_number` | text | Yes | - | Recipient phone number in E.164 format (e.g., +1234567890) |
| `message_body` | text | Yes | - | Message body text (max 1600 characters) |
| `from_number` | text | No | `TWILIO_PHONE_NUMBER` | Optional: Override sender phone number |

### Response

```json
{
  "success": true,
  "message_sid": "SM1234567890abcdef",
  "status": "queued",
  "to": "+1987654321",
  "from": "+1234567890",
  "log_id": 1
}
```

### Error Response

If the Twilio API returns an error:

```json
{
  "name": "TwilioError",
  "value": "Twilio API error: The 'To' number is not a valid phone number."
}
```

## Files

- `run.xs` - Run job configuration
- `function/send_sms.xs` - SMS sending logic
- `table/sms_log.xs` - Database table for logging SMS messages

## Notes

- Phone numbers must be in E.164 format (e.g., +1234567890)
- Message body has a maximum of 1600 characters
- SMS messages are logged to `sms_log` including failed attempts
- The `status` field will show Twilio's message status (queued, sent, delivered, failed, etc.)
- Use your Twilio test credentials for testing (available in Twilio console)
