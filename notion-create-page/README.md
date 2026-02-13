# Notion Create Page - Xano Run Job

This Xano run job creates a new page in a Notion database using the Notion API.

## What It Does

The run job executes a function that creates a page in a specified Notion database with:

- A title property (mapped to the "Name" field)
- A paragraph block with content
- Full API response including the page URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `notion_api_key` | Your Notion Integration Token (starts with `secret_`) | `secret_xxxxxxxxxxxxxxxx` |
| `notion_database_id` | The ID of the Notion database to add the page to | `xxxxxxxxxxxxxxxxxxxxxxxx` |
| `notion_page_title` | The title for the new page | `My New Page` |

## Optional Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `notion_page_content` | Content for the page body | `Created via Xano Run Job` |

## How to Use

### 1. Create a Notion Integration

1. Go to [Notion Integrations](https://www.notion.so/my-integrations)
2. Click "New integration"
3. Give it a name and select the associated workspace
4. Copy the "Internal Integration Token" (this is your `notion_api_key`)

### 2. Share Database with Integration

1. Open your Notion database
2. Click the "..." menu (top right)
3. Click "Add connections"
4. Select your integration

### 3. Get Database ID

1. Open your Notion database in the browser
2. The URL will look like: `https://www.notion.so/workspace/xxxxxxxxxxxxxxxxxxxxxxxx?v=...`
3. Copy the 32-character string between the last `/` and `?` - this is your database ID

### 4. Set Environment Variables

Configure the required environment variables in your Xano workspace settings.

### 5. Run the Job

Execute the run job using the Xano CLI or dashboard:

```bash
xano run execute notion-create-page
```

## File Structure

```
notion-create-page/
├── run.xs                      # Run job configuration
├── function/
│   └── create_page.xs          # Page creation function
├── README.md                   # This file
└── FEEDBACK.md                 # Development feedback for MCP improvements
```

## Notion API Reference

- **Endpoint**: `POST https://api.notion.com/v1/pages`
- **Auth**: Bearer Token (Integration Token)
- **Headers**:
  - `Authorization: Bearer <token>`
  - `Notion-Version: 2022-06-28`
  - `Content-Type: application/json`
- **Body Parameters**:
  - `parent.database_id`: ID of the database to add page to
  - `properties.Name.title`: Page title array
  - `children`: Array of block content

## Response Format

### Success

```json
{
  "status": "success",
  "message": "Page created successfully in Notion database",
  "page_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "page_url": "https://www.notion.so/My-New-Page-xxxxxxxx",
  "created_time": "2024-01-15T10:30:00.000Z",
  "notion_response": { ... }
}
```

### Error

```json
{
  "status": "error",
  "message": "Failed to create page. Status: 400, Error: ...",
  "notion_response": { ... }
}
```

## Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `API token is invalid` | Wrong or expired token | Check your integration token |
| `database_id is required` | Database not shared | Share the database with your integration |
| `Could not find database` | Wrong database ID | Verify the 32-character database ID |
| `Title is a required property` | Database requires title | Ensure your database has a "Name" field |

## Testing

Use a test database before running against production data. Notion API changes are immediate and cannot be undone via API.

## Security Notes

- Never expose your Notion API key in client-side code
- Use Internal Integration (not Public OAuth) for simple automation
- Consider creating a dedicated integration with limited database access
- Store the database ID securely - it identifies your data structure

## Notes

- The page title is mapped to the "Name" property (standard for Notion databases)
- Content is added as a paragraph block
- The database must have at least one property named "Name" or the title won't display correctly
- Notion's API has rate limits (approximately 3 requests per second)
