# Webflow Create CMS Item

A Xano Run Job that creates CMS items in Webflow collections using the Webflow API v2.

## What This Run Job Does

This run job creates a new CMS item in a specified Webflow collection. It's useful for:

- Automating content publishing to Webflow CMS
- Syncing data from external sources to Webflow
- Bulk importing content into Webflow collections
- Building headless CMS workflows with Webflow

## Prerequisites

1. A Webflow account with API access
2. A Webflow site with at least one CMS collection
3. A Webflow API token (v2 API)

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `webflow_api_token` | Your Webflow API v2 token | [Webflow API Settings](https://developers.webflow.com/docs/getting-started) |
| `webflow_site_id` | Your Webflow site ID | From your Webflow dashboard URL or API |

## How to Use

### Basic Usage

```json
{
  "collection_id": "your-collection-id",
  "item_name": "My New Blog Post",
  "slug": "my-new-blog-post"
}
```

### With Custom Fields

```json
{
  "collection_id": "your-collection-id",
  "item_name": "My New Blog Post",
  "slug": "my-new-blog-post",
  "fields": {
    "author": "John Doe",
    "category": "Technology",
    "published-date": "2024-01-15T00:00:00Z",
    "summary": "A brief summary of the post...",
    "content": "Full article content goes here..."
  }
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `collection_id` | text | Yes | The Webflow collection ID where the item will be created |
| `item_name` | text | Yes | The name of the CMS item (maps to the "Name" field in Webflow) |
| `slug` | text | No | The URL slug for the item. If not provided, Webflow will auto-generate |
| `fields` | json | No | Additional custom fields as key-value pairs (specific to your collection schema) |

## Output

On success, returns:

```json
{
  "success": true,
  "item_id": "item-uuid-here",
  "item_name": "My New Blog Post",
  "collection_id": "collection-id-here",
  "created_at": "2024-01-15T10:30:00.000Z",
  "data": { /* full Webflow API response */ }
}
```

## Error Handling

The run job handles common Webflow API errors:

- **400 Bad Request**: Invalid input data or schema mismatch
- **401 Unauthorized**: Invalid or expired API token
- **404 Not Found**: Collection ID doesn't exist
- **Other errors**: Returned with full API response for debugging

## Webflow API v2 Notes

This implementation uses Webflow's v2 API with these characteristics:

- Uses `fieldData` structure for item data
- Requires Bearer token authentication
- Creates items as "staged" by default (not published)
- Returns comprehensive error messages for debugging

## Finding Your Collection ID

You can find your collection ID by:

1. Using the Webflow API: `GET /v2/sites/{site_id}/collections`
2. Checking your Webflow Designer URL when editing a collection
3. Using the Xano `api.request` to list collections with your site ID

## Links

- [Webflow API Documentation](https://developers.webflow.com/)
- [Webflow API v2 Reference](https://developers.webflow.com/reference)
- [Webflow CMS Collections](https://university.webflow.com/lesson/intro-to-the-cms-and-collections)
