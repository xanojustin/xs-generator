# Notion Create Page Run Job

This Xano Run Job creates pages in Notion databases using the [Notion API](https://developers.notion.com) - a powerful workspace platform for notes, docs, and wikis.

## What It Does

This run job demonstrates how to programmatically create pages in Notion databases. It includes:

- Page creation with title and content
- Support for Notion database properties
- Tag management via multi-select fields
- Rich text content blocks
- Error handling for API failures
- Environment variable security for API keys

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `NOTION_API_KEY` | Your Notion API integration token (starts with `secret_`) |

Get your API key from: https://www.notion.so/my-integrations

## How to Use

### 1. Set Up Environment Variable

```bash
export NOTION_API_KEY="secret_xxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### 2. Share Database with Integration

Before the integration can access your database, you must share it:

1. Open your Notion workspace
2. Go to the database you want to use
3. Click the `...` menu → `Add connections`
4. Select your integration

### 3. Get Your Database ID

From a database URL like:
```
https://www.notion.so/workspace/12345678-1234-1234-1234-123456789abc?v=...
```

The database ID is: `12345678-1234-1234-1234-123456789abc`

### 4. Modify the Run Job

Edit `run.xs` to customize the page:

```xs
run.job "Create Notion Page" {
  main = {
    name: "create_notion_page"
    input: {
      database_id: "YOUR-DATABASE-ID-HERE"
      title: "My Project Update"
      content: "This page was automatically created via the Notion API!"
      tags: ["Project", "Automated", "Xano"]
      properties: {
        Status: {
          select: { name: "In Progress" }
        }
        Priority: {
          select: { name: "High" }
        }
      }
    }
  }
  env = ["NOTION_API_KEY"]
}
```

### 5. Run the Job

```bash
xano run execute --job "Create Notion Page"
```

Or use the Run API:

```bash
curl -X POST https://app.dev.xano.com/api:run/v1/run \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "job": "notion-create-page",
    "env": {
      "NOTION_API_KEY": "secret_xxx"
    }
  }'
```

## Function Reference

### `create_notion_page`

Creates a new page in a Notion database.

**Input Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `database_id` | text | Yes | The Notion database ID to create the page in |
| `title` | text | Yes | The page title (must match your database's title property) |
| `content` | text? | No | Optional body content as paragraph text |
| `tags` | text[]? | No | Optional array of tags for multi-select fields |
| `properties` | json? | No | Additional Notion property objects (status, select, date, etc.) |

**Response:**

```json
{
  "success": true,
  "page_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "database_id": "12345678-1234-1234-1234-123456789abc",
  "title": "My Project Update",
  "url": "https://notion.so/page-url",
  "created_time": "2024-01-15T10:30:00.000Z"
}
```

## File Structure

```
notion-create-page/
├── run.xs                      # Run job configuration
├── function/
│   └── create_notion_page.xs   # Page creation function
├── README.md                   # This file
└── FEEDBACK.md                 # MCP feedback documentation
```

## Notion Property Types

The Notion API supports various property types. Here are common ones:

```json
{
  // Select (single choice)
  "Status": { "select": { "name": "In Progress" } },
  
  // Multi-select (tags)
  "Tags": { "multi_select": [{ "name": "Xano" }, { "name": "API" }] },
  
  // Date
  "Due Date": { "date": { "start": "2024-01-15" } },
  
  // Person (user mention)
  "Assignee": { "people": [{ "id": "user-id-here" }] },
  
  // URL
  "Link": { "url": "https://example.com" },
  
  // Email
  "Contact": { "email": "user@example.com" },
  
  // Phone
  "Phone": { "phone_number": "+1-555-123-4567" },
  
  // Number
  "Priority": { "number": 1 },
  
  // Checkbox
  "Completed": { "checkbox": true },
  
  // Rich text
  "Description": { "rich_text": [{ "text": { "content": "Details here" } }] }
}
```

## Customization Ideas

- **Task Management**: Create tasks with due dates and assignees
- **Content Publishing**: Draft blog posts with structured content
- **CRM Integration**: Log customer interactions automatically
- **Project Tracking**: Create project pages from external triggers
- **Knowledge Base**: Auto-generate documentation pages
- **Meeting Notes**: Create structured meeting notes from calendar events

## Resources

- Notion API Docs: https://developers.notion.com/reference
- Notion Integrations: https://www.notion.so/my-integrations
- XanoScript Docs: Use `xanoscript_docs` MCP tool
