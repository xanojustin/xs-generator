# Mailchimp Add Contact Run Job

This XanoScript run job adds a contact to a Mailchimp audience/list using the Mailchimp Marketing API.

## What It Does

This run job creates a new audience member in your Mailchimp account. It handles:

- Adding a contact with email address to a Mailchimp audience
- Setting subscription status (subscribed, unsubscribed, cleaned, pending)
- Adding first and last name merge fields
- Applying tags to the contact for segmentation
- Returning the member ID and confirmation status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MAILCHIMP_API_KEY` | Your Mailchimp API key (get from Account → Extras → API Keys) |
| `MAILCHIMP_SERVER_PREFIX` | Your Mailchimp server prefix (e.g., `us1`, `us21`, found in your API key or URL) |
| `MAILCHIMP_AUDIENCE_ID` | Your Mailchimp audience/list ID (found in Audience → Settings → Audience name and defaults) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | Email address of the contact to add |
| `first_name` | text | No | First name of the contact |
| `last_name` | text | No | Last name of the contact |
| `status` | text | No | Subscription status: `subscribed`, `unsubscribed`, `cleaned`, `pending` (default: `subscribed`) |
| `tags` | text | No | Comma-separated list of tags to apply (e.g., `newsletter,vip,xano`) |

### Response

```json
{
  "success": true,
  "member_id": "abc123def456",
  "email": "test@example.com",
  "status": "subscribed",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "member_id": null,
  "email": null,
  "status": null,
  "error": "Member already exists in this list with a subscribed status."
}
```

## File Structure

```
mailchimp-add-contact/
├── run.xs                    # Run job definition
├── function/
│   └── add_contact.xs        # Function to add contact to Mailchimp
└── README.md                 # This file
```

## Mailchimp API Reference

- [Marketing API - Add Member to List](https://mailchimp.com/developer/marketing/api/list-members/add-member-to-list/)
- [Getting Started with Mailchimp API](https://mailchimp.com/developer/marketing/guides/quick-start/)

## Finding Your Credentials

### API Key
1. Log in to Mailchimp
2. Click your profile picture → Account → Extras → API Keys
3. Create a new API key if needed

### Server Prefix
- Found in your API key: `yourkey-us21` → prefix is `us21`
- Or look at your Mailchimp URL: `https://us21.admin.mailchimp.com/`

### Audience ID
1. Go to Audience → All contacts
2. Click Settings → Audience name and defaults
3. The Audience ID is displayed there (looks like a 10-character string)

## Testing

Use a test email address for development:
- `test@example.com` - Safe for testing
- Use `+` notation for multiple tests: `test+1@example.com`, `test+2@example.com`

## Security Notes

- Never commit your `MAILCHIMP_API_KEY` to version control
- Use Mailchimp's test audiences during development
- The API key grants full access to your Mailchimp account - keep it secure
- Consider using merge fields to store additional contact data securely

## Tagging Strategy

Tags are useful for segmenting your audience:
- `newsletter` - General newsletter subscribers
- `vip` - High-value customers
- `prospect` - Potential customers
- `customer` - Existing customers
- Source tags like `xano`, `website`, `import`
