# Mailchimp Add Subscriber

A Xano Run Job that adds a subscriber to a Mailchimp audience/list using the Mailchimp Marketing API.

## What This Run Job Does

This run job integrates with the Mailchimp Marketing API to add new subscribers to a specified Mailchimp audience (list). It handles:

- Email subscription with validation
- Optional first and last name merge fields
- Proper error handling for common failure scenarios
- HTTP Basic Authentication with the Mailchimp API

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `mailchimp_api_key` | Your Mailchimp API key | `abc123def456-us1` |
| `mailchimp_server_prefix` | Your Mailchimp server prefix | `us1`, `us14` |

### Finding Your Credentials

1. **API Key**: Log into Mailchimp → Account → Extras → API Keys → Create A Key
2. **Server Prefix**: Found in your API key after the dash (e.g., `us1`) or in your Mailchimp URL: `https://us1.admin.mailchimp.com`

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | text | Yes | Subscriber's email address |
| `first_name` | text | No | Subscriber's first name |
| `last_name` | text | No | Subscriber's last name |
| `audience_id` | text | Yes | Mailchimp audience/list ID |

### Finding Your Audience ID

1. In Mailchimp, go to Audience → All contacts
2. Select your audience
3. Click Settings → Audience name and defaults
4. The Audience ID is displayed at the bottom

## Usage Example

### Via Xano Run

```
POST /run/mailchimp-add-subscriber
```

**Request Body:**
```json
{
  "email": "john.doe@example.com",
  "first_name": "John",
  "last_name": "Doe",
  "audience_id": "a1b2c3d4e5"
}
```

**Environment:**
```
mailchimp_api_key=your-api-key-here
mailchimp_server_prefix=us1
```

## Response

### Success Response (200)

```json
{
  "id": "a1b2c3d4e5f6",
  "email_address": "john.doe@example.com",
  "unique_email_id": "abc123def456",
  "contact_id": "xyz789",
  "status": "subscribed",
  "merge_fields": {
    "FNAME": "John",
    "LNAME": "Doe"
  },
  "list_id": "a1b2c3d4e5"
}
```

### Error Responses

| Error | Cause | Solution |
|-------|-------|----------|
| `inputerror` | Missing email or audience_id | Check required parameters |
| `MailchimpAuthError` | Invalid API key | Verify your API key |
| `MailchimpNotFound` | Invalid audience ID | Check your audience ID |
| `MailchimpBadRequest` | Invalid email or already subscribed | Check email format or if already subscribed |

## API Reference

This integration uses the Mailchimp Marketing API v3.0:
- Endpoint: `POST /3.0/lists/{list_id}/members`
- Documentation: https://mailchimp.com/developer/marketing/api/list-members/

## Files

| File | Description |
|------|-------------|
| `run.xs` | Run job configuration |
| `function/mailchimp_add_subscriber.xs` | Main function implementation |
| `types.xs` | Type definitions for inputs/outputs |
| `test.xs` | Test cases with sample data |

## License

MIT - Part of the XanoScript examples collection
