# MessageBird Send SMS - Xano Run Job

This Xano Run Job sends SMS messages using the MessageBird API. It demonstrates how to integrate with MessageBird's omnichannel messaging platform from Xano.

## What This Run Job Does

The `MessageBird Send SMS` run job sends text messages by:
1. Accepting message details (recipient phone number, sender ID, message body)
2. Making an authenticated request to MessageBird's `/messages` endpoint
3. Returning the message object with details like message ID, status, and delivery information

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `messagebird_api_key` | Your MessageBird API Access Key | `live_abc123...` or `test_abc123...` |

### Getting Your MessageBird API Key

1. Sign up or log in to your [MessageBird Dashboard](https://dashboard.messagebird.com)
2. Go to Settings → API Keys
3. Copy your **Access Key** (starts with `live_` for production or `test_` for testing)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "MessageBird Send SMS"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "MessageBird Send SMS"
}
```

### Customizing the Message

Edit the `input` block in `run.xs`:

```xs
run.job "MessageBird Send SMS" {
  main = {
    name: "messagebird_send_sms"
    input: {
      recipient: "+14155552671"      // Recipient phone number in E.164 format
      originator: "YourBrand"         // Sender ID (max 11 alphanumeric chars)
      message: "Your custom message here!"
    }
  }
  env = ["messagebird_api_key"]
}
```

### Phone Number Format

MessageBird requires phone numbers in E.164 format:
- Include the `+` prefix
- Include country code
- No spaces, dashes, or other formatting
- Examples: `+1234567890` (US), `+442071838750` (UK), `+31612345678` (Netherlands)

### Originator Options

The originator (sender ID) can be:
- An alphanumeric string (max 11 characters): `YourBrand`
- A phone number in E.164 format: `+1234567890`
- Some countries restrict which originators are allowed

## File Structure

```
messagebird-send-sms/
├── run.xs                          # Run job configuration
├── function/
│   └── messagebird_send_sms.xs     # Function that calls MessageBird API
├── README.md                       # This file
└── FEEDBACK.md                     # MCP feedback for Justin
```

## Response Format

On success, the function returns a MessageBird Message object:

```json
{
  "id": "e8077d803532c0b5937c639b60216938",
  "href": "https://rest.messagebird.com/messages/e8077d803532c0b5937c639b60216938",
  "direction": "mt",
  "type": "sms",
  "originator": "XanoSMS",
  "body": "Hello from Xano Run Job!",
  "reference": null,
  "validity": null,
  "gateway": 10,
  "typeDetails": {},
  "datacoding": "plain",
  "mclass": 1,
  "scheduledDatetime": null,
  "createdDatetime": "2024-01-15T10:30:00+00:00",
  "recipients": {
    "totalCount": 1,
    "totalSentCount": 1,
    "totalDeliveredCount": 0,
    "totalDeliveryFailedCount": 0,
    "items": [
      {
        "recipient": 1234567890,
        "status": "sent",
        "statusDatetime": "2024-01-15T10:30:00+00:00"
      }
    ]
  }
}
```

### Recipient Status Values

- `scheduled` - Message is scheduled for later delivery
- `sent` - Message has been sent to the carrier
- `buffered` - Message is buffered by the carrier
- `delivered` - Message has been delivered to the recipient
- `expired` - Message expired before delivery
- `delivery_failed` - Message delivery failed

## Error Handling

The function throws a `MessageBirdAPIError` if:
- The MessageBird API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- The phone number is invalid or improperly formatted
- The originator is not allowed for the destination country

## Testing

MessageBird provides a test environment that doesn't actually send messages:

1. Use a test API key (starts with `test_`)
2. Messages will not be delivered to real phones
3. You can verify your integration without incurring costs

## Pricing

MessageBird operates on a pay-per-use model:
- SMS pricing varies by destination country
- Check [MessageBird Pricing](https://messagebird.com/en-us/pricing/) for current rates
- Test messages using test keys are free

## Security Notes

- **Never commit your MessageBird API key** - always use environment variables
- Use test keys during development
- Only use live keys in production
- Consider implementing message templates for consistent messaging
- Be aware of local regulations (GDPR, TCPA, etc.) when sending SMS

## Additional Resources

- [MessageBird API Documentation](https://developers.messagebird.com/api/sms-messaging/)
- [MessageBird Dashboard](https://dashboard.messagebird.com)
- [Phone Number Formatting (E.164)](https://developers.messagebird.com/concepts/phonenumbers/)
- [XanoScript Documentation](https://docs.xano.com)

## Other MessageBird Capabilities

MessageBird supports many other messaging channels:
- **WhatsApp** - Send messages via WhatsApp Business API
- **Voice** - Make calls and send voice messages
- **Email** - Send transactional emails
- **RCS** - Rich Communication Services messaging
- **Instagram** - Messaging via Instagram API
- **Telegram** - Send Telegram messages

This run job focuses on SMS, but the pattern can be adapted for other channels.
