# Cloudflare Purge Cache Run Job

This XanoScript run job purges the Cloudflare CDN cache for specific URLs, cache tags, or the entire zone.

## What It Does

This run job interacts with the Cloudflare API to purge cached content from Cloudflare's edge servers. It supports three purge methods:

1. **Purge by URL** - Purge specific URLs from the cache
2. **Purge by Cache Tags** - Purge content by cache tags (requires Enterprise plan)
3. **Purge Everything** - Purge the entire cache for a zone (use with caution!)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `CLOUDFLARE_API_TOKEN` | Your Cloudflare API token with Zone.Cache Purge permission |

### Creating a Cloudflare API Token

1. Go to [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens)
2. Click "Create Token"
3. Use the "Custom token" template
4. Grant the following permissions:
   - Zone > Cache Purge > Purge
5. Set Zone Resources to include the zone(s) you want to purge
6. Create the token and copy it for use as `CLOUDFLARE_API_TOKEN`

## How to Use

### Finding Your Zone ID

1. Log into Cloudflare Dashboard
2. Select your domain
3. The Zone ID is displayed in the right sidebar under "API" section

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `zone_id` | text | Yes | Cloudflare Zone ID for the domain |
| `urls` | object | No | Array of URLs to purge (e.g., `["https://example.com/page1"]`) |
| `tags` | object | No | Array of cache tags to purge (Enterprise plan only) |
| `purge_everything` | boolean | No | Set to `true` to purge entire cache (default: `false`) |

**Note:** You must specify at least one of `urls`, `tags`, or `purge_everything`.

### Response

```json
{
  "success": true,
  "result": {
    "id": "purge-request-id"
  },
  "errors": null,
  "messages": null,
  "error_message": null
}
```

### Error Response

```json
{
  "success": false,
  "result": null,
  "errors": [
    {
      "code": 1002,
      "message": "Invalid zone identifier"
    }
  ],
  "messages": null,
  "error_message": "Invalid zone identifier"
}
```

## File Structure

```
cloudflare-purge-cache/
├── run.xs                    # Run job definition
├── function/
│   └── purge_cache.xs        # Function to purge cache
└── README.md                 # This file
```

## Cloudflare API Reference

- [Purge Cache by URL](https://developers.cloudflare.com/api/operations/zone-purge)
- [Purge Cache by Tags](https://developers.cloudflare.com/api/operations/zone-purge)
- [Purge Everything](https://developers.cloudflare.com/api/operations/zone-purge)

## Important Notes

- **Rate Limits**: Cloudflare allows approximately 1,200 cache purge API calls per 5 minutes per zone
- **Enterprise Only**: Cache tag purging requires a Cloudflare Enterprise plan
- **Use with Caution**: `purge_everything` should be used sparingly as it purges ALL cached content
- **URL Format**: URLs must include the protocol (https://) and match exactly what's cached

## Security Notes

- Never commit your `CLOUDFLARE_API_TOKEN` to version control
- Use API tokens with minimal required permissions (Zone.Cache Purge only)
- Restrict the token to specific zones when possible
