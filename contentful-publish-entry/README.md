# Contentful Publish Entry Run Job

This XanoScript run job creates or updates content entries in Contentful, a popular headless CMS.

## What It Does

This run job integrates with the Contentful Management API to:

- Create new content entries with structured fields
- Update existing entries by ID
- Publish entries immediately after creation (optional)
- Support multiple environments (master, staging, etc.)
- Handle localized content fields

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `CONTENTFUL_MANAGEMENT_TOKEN` | Your Contentful Personal Access Token from Settings > CMA tokens |
| `CONTENTFUL_SPACE_ID` | Default space ID (can be overridden per request) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `space_id` | text | No | Contentful space ID (uses env var if not provided) |
| `environment` | text | No | Environment ID (default: `master`) |
| `content_type` | text | Yes | Content type ID (e.g., `blogPost`, `article`, `product`) |
| `entry_id` | text | No | Existing entry ID to update (creates new if empty) |
| `fields` | object | Yes | Entry fields with locale keys |
| `publish` | boolean | No | Whether to publish immediately (default: `true`) |

### Fields Object Format

Contentful uses locale-keyed fields:

```json
{
  "title": {
    "en-US": "My Blog Post Title"
  },
  "slug": {
    "en-US": "my-blog-post-slug"
  },
  "body": {
    "en-US": {
      "nodeType": "document",
      "data": {},
      "content": [
        {
          "nodeType": "paragraph",
          "data": {},
          "content": [
            {
              "nodeType": "text",
              "value": "Hello World",
              "marks": [],
              "data": {}
            }
          ]
        }
      ]
    }
  }
}
```

### Response

```json
{
  "success": true,
  "entry_id": "3z8x7y6w5v4u3t2s1r0q",
  "version": 2,
  "published": true,
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "entry_id": null,
  "version": null,
  "published": false,
  "error": "No content type with name or id 'invalidType' found."
}
```

## File Structure

```
contentful-publish-entry/
├── run.xs                    # Run job definition
├── function/
│   └── publish_entry.xs      # Function to publish entries
└── README.md                 # This file
```

## Contentful API Reference

- [Content Management API](https://www.contentful.com/developers/docs/references/content-management-api/)
- [Content Model Guide](https://www.contentful.com/developers/docs/concepts/data-model/)
- [Rich Text Format](https://www.contentful.com/developers/docs/concepts/rich-text/)

## Getting Your Management Token

1. Log into Contentful
2. Go to Settings → CMA tokens
3. Generate a new Personal Access Token
4. Copy the token value (starts with `CFPAT-`)

## Content Type Setup

Before using this run job, ensure you have:

1. Created a space in Contentful
2. Defined content types (e.g., blog post, article, product)
3. Know the content type ID (found in the content model settings)

## Security Notes

- Never commit your `CONTENTFUL_MANAGEMENT_TOKEN` to version control
- Use environment-specific tokens when possible
- The management token has full access to your space - keep it secure
- Consider using separate spaces for development and production

## Example: Creating a Simple Blog Post

```json
{
  "space_id": "abc123xyz",
  "environment": "master",
  "content_type": "blogPost",
  "fields": {
    "title": { "en-US": "Getting Started with Contentful" },
    "slug": { "en-US": "getting-started-contentful" },
    "excerpt": { "en-US": "Learn how to use Contentful CMS..." }
  },
  "publish": true
}
```
