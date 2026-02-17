# Bitly Shorten URL - Xano Run Job

This Xano Run Job shortens URLs using the Bitly API. It demonstrates how to integrate with Bitly's link management service from Xano.

## What This Run Job Does

The `Bitly Shorten URL` run job creates a shortened link by:
1. Accepting a long URL and optional parameters (custom domain, title, tags)
2. Making an authenticated request to Bitly's `/v4/shorten` endpoint
3. Returning the shortened link object with details like the short URL, creation date, and link ID

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `bitly_api_token` | Your Bitly API Access Token | `abc123def456...` |

### Getting Your Bitly API Token

1. Log in to your [Bitly Dashboard](https://app.bitly.com)
2. Go to Settings → API → Access Tokens
3. Click "Generate Token" and copy the generated token
4. Alternatively, use the [Bitly API Documentation](https://dev.bitly.com/docs/getting-started/authentication/) for OAuth flow

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Bitly Shorten URL"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Bitly Shorten URL"
}
```

### Customizing the URL

Edit the `input` block in `run.xs`:

```xs
run.job "Bitly Shorten URL" {
  main = {
    name: "bitly_shorten"
    input: {
      long_url: "https://www.yoursite.com/very/long/path"
      domain: "bit.ly"        // Optional: Your custom domain if configured
      title: "My Short Link"  // Optional: Descriptive title
    }
  }
  env = ["bitly_api_token"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `long_url` | text | Yes | The URL to shorten (must include http:// or https://) |
| `domain` | text | No | Custom domain (default: bit.ly). Must be pre-configured in Bitly. |
| `title` | text | No | A title to associate with the link |
| `tags` | text[] | No | Array of tags to categorize the link |

## File Structure

```
bitly-shorten-url/
├── run.xs                      # Run job configuration
├── function/
│   └── bitly_shorten.xs        # Function that calls Bitly API
└── README.md                   # This file
```

## Response Format

On success, the function returns a Bitly Shorten response:

```json
{
  "created_at": "2025-02-17T00:00:00+0000",
  "id": "bit.ly/3ABC123",
  "link": "https://bit.ly/3ABC123",
  "custom_bitlinks": [],
  "long_url": "https://www.example.com/very/long/url/path",
  "archived": false,
  "tags": [],
  "deeplinks": [],
  "references": {
    "group": "https://api-ssl.bitly.com/v4/groups/ABC123"
  }
}
```

### Key Response Fields

| Field | Description |
|-------|-------------|
| `id` | The unique Bitly link identifier (e.g., "bit.ly/3ABC123") |
| `link` | The full shortened URL to share |
| `long_url` | The original URL that was shortened |
| `created_at` | ISO 8601 timestamp of when the link was created |

## Error Handling

The function throws a `BitlyAPIError` if:
- The Bitly API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API token)
- The URL is invalid or missing protocol (http:// or https://)
- Rate limits are exceeded

### Common Error Codes

| HTTP Status | Description |
|-------------|-------------|
| 400 | Bad Request - Invalid URL format or parameters |
| 401 | Unauthorized - Invalid or missing API token |
| 403 | Forbidden - Token lacks permission or rate limit exceeded |
| 422 | Unprocessable Entity - Domain not configured for this account |
| 500 | Bitly Internal Server Error |

## Security Notes

- **Never commit your Bitly API token** - always use environment variables
- Keep your API token secure - it grants access to your Bitly account
- Consider implementing token rotation for production use
- The API token should have appropriate scopes (create links at minimum)

## Additional Resources

- [Bitly API Documentation](https://dev.bitly.com/api-reference)
- [Bitly Authentication Guide](https://dev.bitly.com/docs/getting-started/authentication/)
- [XanoScript Documentation](https://docs.xano.com)
