# Vonage Send SMS - Xano Run Job

This Xano Run Job sends SMS messages using the Vonage (formerly Nexmo) SMS API.

## What It Does

The `send_sms` function makes an HTTP POST request to Vonage's SMS API to send a text message to a specified phone number.

## Prerequisites

1. A Vonage account with API credentials
2. A Vonage phone number for sending SMS

## Required Environment Variables

Set these in your Xano workspace environment variables:

| Variable | Description |
|----------|-------------|
| `vonage_api_key` | Your Vonage API key |
| `vonage_api_secret` | Your Vonage API secret |
| `vonage_from_number` | Your Vonage phone number (e.g., "VonageNum" or your brand name) |

## How to Use

### Run the Job

```bash
# Via Xano Run
xano run execute --job="Vonage Send SMS"
```

### Call the Function Directly

```xs
function.run "send_sms" {
  input = {
    to: "+1234567890",
    message: "Hello from Xano!"
  }
} as $result
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to` | text | Yes | Recipient phone number in E.164 format (e.g., +1234567890) |
| `message` | text | Yes | The SMS message content |

## Response

On success, returns an object with:

```json
{
  "success": true,
  "message_id": "0A00000000000000",
  "to": "1234567890",
  "remaining_balance": "100.00",
  "message_price": "0.05",
  "network": "310004"
}
```

## API Reference

This integration uses the [Vonage SMS API](https://developer.vonage.com/api/sms):

- **Endpoint**: `https://rest.nexmo.com/sms/json`
- **Method**: POST
- **Auth**: API key + API secret in request body

## Error Handling

The job validates:
- HTTP response status (2xx = success)
- Vonage API status code (0 = success)
- Returns descriptive error messages on failure

## Files

- `run.xs` - Run job configuration
- `function/send_sms.xs` - SMS sending logic
