# Mailchimp Add Subscriber Run Job

A XanoScript run job that adds subscribers to a Mailchimp audience (list).

## What It Does

This run job adds a new subscriber to your Mailchimp audience with support for:
- Email subscription with configurable status (subscribed, pending, unsubscribed)
- First and last name merge fields
- Idempotent updates (uses email MD5 hash as subscriber ID)

Perfect for newsletter signups, user registration flows, or marketing automation.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `mailchimp_api_key` | Your Mailchimp API key |
| `mailchimp_server_prefix` | Your Mailchimp server prefix (e.g., `us1`, `us14`) |
| `list_id` | Your Mailchimp audience/list ID |

### Getting Your Credentials

1. **API Key**: https://us1.admin.mailchimp.com/account/api/
2. **Server Prefix**: Found in your API key after the dash (e.g., `us1` in `key-us1`)
3. **List ID**: Audience → Settings → Audience name and defaults

## How to Use

### 1. Set Environment Variables

```bash
export mailchimp_api_key="your_api_key_here"
export mailchimp_server_prefix="us1"
export mailchimp_list_id="your_list_id_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

### 3. Customize the Subscriber

Edit the `input` block in `run.xs`:

```xs
run.job "Mailchimp Add Subscriber" {
  main = {
    name: "mailchimp_add_subscriber"
    input: {
      email: "jane@example.com"
      first_name: "Jane"
      last_name: "Smith"
      status: "subscribed"
    }
  }
  env = ["mailchimp_api_key", "mailchimp_server_prefix", "mailchimp_list_id"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | Subscriber's email address |
| `first_name` | text | No | Subscriber's first name |
| `last_name` | text | No | Subscriber's last name |
| `status` | text | No | Subscription status: `subscribed`, `pending`, `unsubscribed` |

### Status Options

| Status | Description |
|--------|-------------|
| `subscribed` | Immediately subscribed (no confirmation email) |
| `pending` | Sends confirmation email (double opt-in) |
| `unsubscribed` | Adds as unsubscribed |
| `cleaned` | Bounced/cleaned address |

## File Structure

```
mailchimp-add-subscriber/
├── run.xs                              # Run job configuration
├── functions/
│   └── mailchimp_add_subscriber.xs     # Function that calls Mailchimp API
└── README.md                           # This file
```

## API Reference

- **Endpoint**: `PUT /3.0/lists/{list_id}/members/{subscriber_hash}`
- **Documentation**: https://mailchimp.com/developer/marketing/api/list-members/

## Response

On success:

```json
{
  "success": true,
  "email": "subscriber@example.com",
  "subscriber_id": "abc123def456",
  "list_id": "a1b2c3d4e5",
  "status": "subscribed",
  "first_name": "John",
  "last_name": "Doe"
}
```

## Error Handling

Validates:
- Required email address
- Environment variables configured
- API response status

## License

MIT
