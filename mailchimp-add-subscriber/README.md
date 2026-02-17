# Mailchimp Add Subscriber - Xano Run Job

This Xano Run Job adds a new subscriber to your Mailchimp audience/list. It demonstrates how to integrate with Mailchimp's Marketing API from Xano.

## What This Run Job Does

The `Mailchimp Add Subscriber` run job:
1. Accepts subscriber details (email, first name, last name, audience ID)
2. Validates the required inputs
3. Makes an authenticated POST request to Mailchimp's `/3.0/lists/{audience_id}/members` endpoint
4. Handles various response codes (success, auth errors, validation errors)
5. Returns the created subscriber object with details like subscriber ID, status, and timestamps

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `mailchimp_api_key` | Your Mailchimp API Key | `your_api_key_here-us1` |
| `mailchimp_server_prefix` | Your Mailchimp server prefix | `us1`, `us14`, `us20` |

### Getting Your Mailchimp Credentials

1. **API Key:**
   - Log in to your [Mailchimp Account](https://login.mailchimp.com)
   - Go to Account → Extras → API Keys
   - Create a new API key or copy an existing one
   - The API key ends with a dash and server prefix (e.g., `-us1`)

2. **Server Prefix:**
   - Look at your Mailchimp URL when logged in: `https://us1.admin.mailchimp.com/`
   - The server prefix is the part before `.admin.mailchimp.com` (e.g., `us1`)
   - Alternatively, extract it from your API key (the part after the last dash)

3. **Audience ID:**
   - Go to Audience → All contacts
   - Click on Settings → Audience name and defaults
   - Copy the **Audience ID** (looks like a 10-character alphanumeric string)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Mailchimp Add Subscriber"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Mailchimp Add Subscriber"
}
```

### Customizing the Subscriber

Edit the `input` block in `run.xs`:

```xs
run.job "Mailchimp Add Subscriber" {
  main = {
    name: "mailchimp_add_subscriber"
    input: {
      email: "user@example.com"
      first_name: "John"
      last_name: "Doe"
      audience_id: "a1b2c3d4e5"
    }
  }
  env = ["mailchimp_api_key", "mailchimp_server_prefix"]
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | text | Yes | Subscriber's email address |
| `first_name` | text | No | Subscriber's first name (optional) |
| `last_name` | text | No | Subscriber's last name (optional) |
| `audience_id` | text | Yes | Mailchimp audience/list ID |

## File Structure

```
mailchimp-add-subscriber/
├── run.xs                           # Run job configuration
├── function/
│   └── mailchimp_add_subscriber.xs  # Function that calls Mailchimp API
├── types.xs                         # Type definitions for inputs/outputs
├── test.xs                          # Test cases with sample inputs
├── README.md                        # This file
└── FEEDBACK.md                      # MCP/XanoScript development feedback
```

## Response Format

On success, the function returns a Mailchimp Member object:

```json
{
  "id": "abc123def456",
  "email_address": "user@example.com",
  "unique_email_id": "xyz789",
  "contact_id": "contact123",
  "full_name": "John Doe",
  "web_id": 123456,
  "email_type": "html",
  "status": "subscribed",
  "consents_to_one_to_one_messaging": true,
  "merge_fields": {
    "FNAME": "John",
    "LNAME": "Doe"
  },
  "stats": {
    "avg_open_rate": 0,
    "avg_click_rate": 0
  },
  "ip_signup": "",
  "timestamp_signup": "",
  "ip_opt": "192.168.1.1",
  "timestamp_opt": "2024-01-15T10:30:00+00:00",
  "member_rating": 2,
  "last_changed": "2024-01-15T10:30:00+00:00",
  "language": "",
  "vip": false,
  "email_client": "",
  "location": {
    "latitude": 0,
    "longitude": 0,
    "gmtoff": 0,
    "dstoff": 0,
    "country_code": "",
    "timezone": ""
  },
  "list_id": "a1b2c3d4e5"
}
```

## Error Handling

The function throws specific error types for different failure scenarios:

| Error Type | HTTP Status | Description |
|------------|-------------|-------------|
| `inputerror` | 400 | Missing required inputs (email, audience_id) |
| `MailchimpAuthError` | 401 | Invalid API key or server prefix |
| `MailchimpBadRequest` | 400 | Invalid email format, already subscribed, or other validation errors |
| `MailchimpNotFound` | 404 | Audience/list ID not found |
| `MailchimpAPIError` | Various | Other Mailchimp API errors |

### Common Error Messages

- **"Email address is required"** - You must provide an email address
- **"Audience ID is required"** - You must provide a Mailchimp audience ID
- **"Mailchimp API key not configured"** - Set the `mailchimp_api_key` environment variable
- **"Mailchimp server prefix not configured"** - Set the `mailchimp_server_prefix` environment variable
- **"Authentication failed"** - Your API key is invalid or expired
- **"Audience/list not found"** - The audience ID doesn't exist in your account

## Security Notes

- **Never commit your Mailchimp API key** - always use environment variables
- Use a dedicated API key for Xano integrations
- The API key grants access to your Mailchimp account - keep it secure
- Consider using Mailchimp's webhook feature to sync subscriber data back to Xano

## Additional Resources

- [Mailchimp Marketing API Documentation](https://mailchimp.com/developer/marketing/api/)
- [Mailchimp API Playground](https://mailchimp.com/developer/marketing/api/playground/)
- [XanoScript Documentation](https://docs.xano.com)

## Testing

Sample test cases are provided in `test.xs`. To run a specific test case:

1. Copy the input from a test case
2. Update the `run.xs` input block with those values
3. Execute the run job

### Test Cases Included

- `basic_subscription` - Standard subscription with all fields
- `email_only` - Minimal subscription with just email
- `special_characters` - Names with special characters (accents, etc.)
- `invalid_email` - Test error handling with invalid email
- `missing_audience` - Test error handling without audience ID