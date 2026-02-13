# Asana Create Task - Xano Run Job

This Xano Run Job creates a new task in an Asana project using the Asana API.

## What It Does

This run job allows you to programmatically create tasks in Asana projects with support for:
- Task name and notes
- Assignee assignment
- Due dates
- Tags
- Priority levels

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `asana_personal_access_token` | Your Asana Personal Access Token from the Asana Developer Console |

## How to Get Your Asana Personal Access Token

1. Go to [Asana Developer Console](https://developers.asana.com/)
2. Sign in to your Asana account
3. Navigate to "My apps" → "Personal access tokens"
4. Click "Create new personal access token"
5. Give it a name (e.g., "Xano Integration") and copy the token

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `project_id` | text | Yes | The Asana project ID (GID) where the task will be created |
| `task_name` | text | Yes | The name/title of the task |
| `task_notes` | text | No | Optional notes/description for the task |
| `assignee_id` | text | No | Optional Asana user ID (GID) to assign the task to |
| `due_date` | text | No | Optional due date in YYYY-MM-DD format |
| `tags_json` | text | No | Optional JSON array of tag GIDs (e.g., `["1200000000000001"]`) |
| `priority` | text | No | Optional priority level: `low`, `normal`, `high`, or `urgent` |

## How to Find Asana IDs

- **Project ID**: Open your project in Asana, look at the URL. The ID is the last part: `https://app.asana.com/0/<PROJECT_ID>/<TASK_ID>`
- **User ID**: Go to the user's profile, the ID is in the URL after `/user/`
- **Tag ID**: Use the Asana API or check the tag's URL

## Example Usage

### Basic Task Creation
```json
{
  "project_id": "1200000000000000",
  "task_name": "Review quarterly report",
  "task_notes": "Please review the Q4 financial report before the meeting."
}
```

### Task with Assignee and Due Date
```json
{
  "project_id": "1200000000000000",
  "task_name": "Update documentation",
  "task_notes": "Update the API documentation with new endpoints.",
  "assignee_id": "1200000000000001",
  "due_date": "2025-03-15",
  "priority": "high"
}
```

### Task with Tags
```json
{
  "project_id": "1200000000000000",
  "task_name": "Fix critical bug",
  "task_notes": "Users are reporting login issues.",
  "assignee_id": "1200000000000001",
  "due_date": "2025-02-20",
  "tags_json": "[\"1200000000000002\", \"1200000000000003\"]",
  "priority": "urgent"
}
```

## Response

On success, the run job returns:

```json
{
  "success": true,
  "task_id": "1200000000000004",
  "task_name": "Review quarterly report",
  "task_url": "https://app.asana.com/0/1200000000000000/1200000000000004",
  "project_id": "1200000000000000",
  "assignee_id": "1200000000000001",
  "due_date": "2025-03-15",
  "created_at": "2025-02-12T23:20:00.000Z"
}
```

## API Reference

This run job uses the [Asana REST API](https://developers.asana.com/reference/createtask):
- **Endpoint**: `POST /tasks`
- **Documentation**: https://developers.asana.com/reference/createtask

## File Structure

```
asana-create-task/
├── run.xs                      # Run job definition
├── functions/
│   └── asana_create_task.xs    # Task creation function
└── README.md                   # This file
```

## Error Handling

The run job validates inputs and handles common errors:
- Missing or invalid project ID
- Missing task name
- Invalid Asana token
- API errors (returns detailed error messages from Asana)

## Rate Limits

Asana API has rate limits. For free accounts, you get 150 requests per minute. Paid accounts get 1500 requests per minute. The run job will fail with appropriate error messages if rate limits are exceeded.