# Rebrandly Shorten URL Run Job

This XanoScript run job shortens URLs using the Rebrandly API.

## What It Does

This run job creates a shortened URL via the Rebrandly API. It handles:

- Creating a short link for any long URL
- Optional custom slashtags (e.g., `rebrand.ly/my-custom-link`)
- Optional link titles for organization
- Optional custom domain selection (defaults to rebrand.ly)
- Returning the short URL and link ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `REBRANDLY_API_KEY` | Your Rebrandly API key (get from https://app.rebrandly.com/account/api-keys) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `destination` | text | Yes | The long URL to shorten (e.g., `https://www.example.com/very/long/path`) |
| `slashtag` | text | No | Custom short URL slug (e.g., `my-link` creates `rebrand.ly/my-link`) |
| `title` | text | No | Title for the branded link (for organization in Rebrandly dashboard) |
| `domain_id` | text | No | Rebrandly domain ID (optional, defaults to `rebrand.ly`) |

### Response

```json
{
  "success": true,
  "short_url": "https://rebrand.ly/example123",
  "link_id": "abc123def456"
}
```

### Error Response

```json
{
  "success": false,
  "short_url": null,
  "link_id": null
}
```

## File Structure

```
rebrandly-shorten-url/
├── run.xs                    # Run job definition
├── function/
│   └── shorten_url.xs        # Function to shorten URL
├── README.md                 # This file
└── FEEDBACK.md               # MCP/XanoScript feedback
```

## Rebrandly API Reference

- [Rebrandly API Documentation](https://developers.rebrandly.com/)
- [Create Link Endpoint](https://developers.rebrandly.com/docs/create-a-new-link)

## Getting a Rebrandly API Key

1. Sign up at https://www.rebrandly.com/
2. Go to Account Settings → API Keys
3. Generate a new API key
4. Set it as the `REBRANDLY_API_KEY` environment variable

## Testing

Use any valid URL for testing:
- `https://www.example.com` 
- `https://www.google.com/search?q=xano`

## Security Notes

- Never commit your `REBRANDLY_API_KEY` to version control
- Use environment variables for all sensitive credentials
- The API key should have appropriate permissions for link creation
