# Notion Create Page Run Job

A XanoScript run job that creates pages in a Notion database from a task queue. This integration allows you to programmatically create Notion pages with properties like title, status, priority, and tags.

## What It Does

This run job:
1. Runs every hour to check for pending tasks in the `notion_tasks_queue` table
2. Creates a new page in your specified Notion database for each pending task
3. Updates the task status to "completed" with the Notion page URL
4. Handles errors gracefully, marking failed tasks for review

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `notion_api_key` | Your Notion integration API key | `secret_abc123...` |
| `notion_database_id` | The ID of your Notion database | `a1b2c3d4e5f6...` |

## How to Get Your Notion API Credentials

1. **Create a Notion Integration:**
   - Go to [https://www.notion.so/my-integrations](https://www.notion.so/my-integrations)
   - Click "New integration"
   - Give it a name and select the workspace
   - Copy the "Internal Integration Token" (this is your `notion_api_key`)

2. **Get Your Database ID:**
   - Open your Notion database in the browser
   - Copy the URL (e.g., `https://www.notion.so/workspace/a1b2c3d4e5f6...?v=...`)
   - The database ID is the part after the last `/` and before the `?v=`

3. **Share Database with Integration:**
   - In Notion, click the "..." menu on your database
   - Select "Add connections"
   - Find and select your integration

## Database Schema

The run job expects a table called `notion_tasks_queue` with these fields:

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Primary key |
| `title` | text | Page title (required) |
| `description` | text | Page content/body |
| `status` | text | Task status (e.g., "Not started", "In progress") |
| `priority` | text | Priority level (e.g., "Low", "Medium", "High") |
| `tags` | text | Comma-separated tags |
| `status` (queue) | text | Queue status: "pending", "completed", "failed" |
| `notion_page_id` | text | ID of created Notion page |
| `notion_url` | text | URL of created Notion page |
| `created_at` | timestamp | When task was created |
| `processed_at` | timestamp | When task was processed |
| `error_message` | text | Error details if failed |

## Usage

### Direct Function Call

You can also call the function directly from other XanoScript code:

```xs
function.run "notion/create_page" {
  input = {
    database_id: "your-database-id"
    title: "My New Task"
    content: "This is the task description"
    status: "In progress"
    priority: "High"
    tags: "urgent, backend, api"
  }
} as $result
```

### Add Task to Queue

```xs
db.add "notion_tasks_queue" {
  data = {
    title: "Implement OAuth"
    description: "Add OAuth2 authentication to the API"
    status: "pending"
    priority: "High"
    tags: "auth, security"
    created_at: now
  }
} as $new_task
```

## Schedule

The run job executes every hour (`freq: 3600` seconds) starting February 13, 2026.

To modify the schedule, edit the `schedule` block in `run.xs`:

```xs
schedule = [{starts_on: 2026-02-13 00:00:00+0000, freq: 3600}]
```

- `freq: 3600` = Every hour
- `freq: 86400` = Every day
- `freq: 604800` = Every week

## Files

| File | Description |
|------|-------------|
| `run.xs` | The scheduled run job |
| `functions/notion/create_page.xs` | Reusable function to create Notion pages |
| `README.md` | This documentation |

## Error Handling

- If `notion_database_id` is not set, the job skips execution
- Failed API calls are caught and logged
- Failed tasks are marked with status "failed" and include error details
- Successfully created pages update the task with Notion page ID and URL

## Notion API Version

This integration uses Notion API version `2022-06-28`.

## Support

For Notion API documentation, visit: https://developers.notion.com/
