# Notion Create Page - Xano Run Job

This Xano Run Job creates a new page in a Notion database using the [Notion API](https://developers.notion.com/) and logs the operation to a database table.

## What It Does

1. Accepts page parameters (database ID, title, content)
2. Creates a page in Notion using the Pages API
3. Logs the operation to the `page_log` table
4. Returns the Notion page ID, URL, and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `NOTION_API_KEY` | Your Notion Integration Token (get from https://www.notion.so/my-integrations) |
| `NOTION_DATABASE_ID` | Default database ID to create pages in (optional, can override per-run) |

## Setup Instructions

1. Create a Notion integration at https://www.notion.so/my-integrations
2. Copy the Internal Integration Token
3. Share your database with the integration (click "..." on database → Add connections)
4. Get your database ID from the Notion URL (the part after the last `/` and before `?`)
5. Set the environment variables in Xano

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "Notion Create Page"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Notion Create Page" {
  main = {
    name: "create_page"
    input: {
      database_id: "abc123-def456-ghi789"
      title: "Meeting Notes"
      content: "Discussion points from today's standup..."
    }
  }
  env = ["NOTION_API_KEY", "NOTION_DATABASE_ID"]
}
```

### Function Inputs

The `create_page` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `database_id` | text | Yes | - | Notion database ID (or uses NOTION_DATABASE_ID env var) |
| `title` | text | Yes | - | The page title (goes in the Name property) |
| `content` | text | No | "" | The page content as a paragraph |

### Response

```json
{
  "success": true,
  "page_id": "abc123-def456-ghi789",
  "url": "https://www.notion.so/Meeting-Notes-abc123",
  "log_id": 1
}
```

### Error Response

If the Notion API returns an error:

```json
{
  "name": "NotionError",
  "value": "Notion API error: Could not find database with ID: abc123"
}
```

## Files

- `run.xs` - Run job configuration
- `function/create_page.xs` - Page creation logic
- `table/page_log.xs` - Database table for logging pages

## Notes

- The database must have a "Name" property (title property) for pages
- The integration must have access to the database
- All pages are logged to `page_log` including failed attempts
- Common errors include "database_not_found" and "unauthorized"
- The Notion API version is pinned to 2022-06-28
