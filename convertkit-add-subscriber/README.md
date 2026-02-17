# ConvertKit Add Subscriber - Xano Run Job

This Xano Run Job adds a new subscriber to your ConvertKit email list. It demonstrates how to integrate with ConvertKit's email marketing API from Xano.

## What This Run Job Does

The `ConvertKit Add Subscriber` run job:
1. Accepts subscriber details (email, first name, optional tags)
2. Makes an authenticated request to ConvertKit's `/v3/subscribers` endpoint
3. Returns the created subscriber object with details like subscriber ID, state, and created_at timestamp

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `convertkit_api_key` | Your ConvertKit API Key | `your_api_key_here` |

### Getting Your ConvertKit API Key

1. Log in to your [ConvertKit Account](https://app.convertkit.com)
2. Go to Settings → Advanced
3. Copy your **API Key**

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "ConvertKit Add Subscriber"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "ConvertKit Add Subscriber"
}
```

### Customizing the Subscriber

Edit the `input` block in `run.xs`:

```xs
run.job "ConvertKit Add Subscriber" {
  main = {
    name: "convertkit_add_subscriber"
    input: {
      email: "user@example.com"
      first_name: "John"
      tags_json: "[123456, 789012]"
    }
  }
  env = ["convertkit_api_key"]
}
```

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `email` | text | Subscriber's email address (required) |
| `first_name` | text | Subscriber's first name (leave empty if not needed) |
| `tags_json` | text | JSON array of tag IDs as a string (e.g., `'[123, 456]'`, use `"[]"` for no tags) |

### Finding Tag IDs

To get tag IDs from ConvertKit:
1. In ConvertKit, go to Grow → Tags
2. Click on a tag
3. The tag ID is in the URL: `/subscribers?tags[]=123456`

## File Structure

```
convertkit-add-subscriber/
├── run.xs                    # Run job configuration
├── function/
│   └── convertkit_add_subscriber.xs  # Function that calls ConvertKit API
├── README.md                 # This file
└── FEEDBACK.md               # MCP/XanoScript development feedback
```

## Response Format

On success, the function returns a ConvertKit Subscriber object:

```json
{
  "subscriber": {
    "id": 12345678,
    "first_name": "John",
    "email_address": "user@example.com",
    "state": "active",
    "created_at": "2024-01-15T10:30:00Z",
    "fields": {},
    "tags": [
      {
        "id": 123456,
        "name": "Newsletter"
      }
    ]
  }
}
```

## Error Handling

The function throws a `ConvertKitAPIError` if:
- The ConvertKit API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- The email address is invalid or already exists

## Security Notes

- **Never commit your ConvertKit API key** - always use environment variables
- Use a dedicated API key for Xano integrations
- Consider using ConvertKit's webhook feature to sync subscriber data back to Xano

## Additional Resources

- [ConvertKit API Documentation](https://developers.convertkit.com/)
- [XanoScript Documentation](https://docs.xano.com)
