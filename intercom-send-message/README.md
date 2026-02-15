# Intercom Send Message Run Job

This XanoScript run job sends messages to contacts or users via the Intercom API.

## What It Does

This run job creates and sends messages through Intercom's messaging platform. It supports:

- Sending email, in-app, or SMS messages
- Targeting existing users by ID or email
- Targeting contacts by contact ID
- Creating new contacts when sending by email
- Custom subject lines for email messages
- Template-based messaging (optional)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `INTERCOM_API_KEY` | Your Intercom API access token (starts with `dG9r...`) |

You can find your API key in Intercom at Settings > Developers > Developer Hub > Your App > Configure > Authentication.

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `message_body` | text | Yes | The message content/body to send |
| `message_type` | text | No | Message type: `email`, `inapp`, or `sms` (default: `email`) |
| `to_user_id` | text | No | Intercom user ID to send message to |
| `to_contact_id` | text | No | Intercom contact ID to send message to |
| `to_email` | text | No | Email address of recipient (creates/updates contact) |
| `subject` | text | No | Subject line for email messages |
| `template_id` | text | No | Intercom template ID to use |
| `use_template` | boolean | No | Whether to use a template (default: `false`) |

**Note:** At least one of `to_user_id`, `to_contact_id`, or `to_email` is required.

### Response

```json
{
  "success": true,
  "message_id": "1234567890",
  "conversation_id": "9876543210",
  "type": "admin_message",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "message_id": null,
  "conversation_id": null,
  "type": null,
  "error": "User not found"
}
```

## File Structure

```
intercom-send-message/
├── run.xs                    # Run job definition
├── function/
│   └── send_message.xs       # Function to send messages
└── README.md                 # This file
```

## Intercom API Reference

- [Messages API](https://developers.intercom.com/docs/references/rest-api/api.intercom.io/messages/)
- [Contacts API](https://developers.intercom.com/docs/references/rest-api/api.intercom.io/contacts/)

## Testing

To test this run job:

1. Set up your `INTERCOM_API_KEY` environment variable
2. Modify the `run.xs` with a real email address or user ID from your Intercom workspace
3. Run the job and check your Intercom inbox for the message

## Message Types

- **email**: Sends an email message to the contact's email address
- **inapp**: Sends an in-app message (requires the Intercom Messenger to be installed)
- **sms**: Sends an SMS message (requires SMS to be configured in Intercom)

## Security Notes

- Never commit your `INTERCOM_API_KEY` to version control
- Use Intercom's test workspace during development if available
- The API key should have appropriate scopes: `read`, `write` for messages
