# Asana Create Task

A XanoScript run job that creates tasks in Asana via the Asana API.

## What It Does

This run job creates a new task in an Asana project with support for:
- Task name and description
- Assignee assignment
- Due dates
- Tags
- Completion status

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `ASANA_ACCESS_TOKEN` | Asana Personal Access Token | Go to Asana → My Profile → Apps → Manage Developer Apps → Create New Personal Access Token |

## How to Use

### Basic Usage

1. Set your `ASANA_ACCESS_TOKEN` environment variable
2. Configure the run job with your project ID
3. Run the job

### Finding Your Project ID

1. Open Asana in your browser
2. Navigate to your project
3. The project ID is in the URL: `https://app.asana.com/0/<PROJECT_ID>/list`

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | text | Yes | Task name/title |
| `project_id` | text | Yes | Asana project ID |
| `notes` | text | No | Task description |
| `assignee` | text | No | Assignee email or user ID |
| `due_on` | text | No | Due date (YYYY-MM-DD format) |
| `tags` | text[] | No | Array of tag names |
| `completed` | bool | No | Whether task is completed (default: false) |

### Example Response

```json
{
  "success": true,
  "task_id": "1201234567890123",
  "task_name": "New Task from Xano",
  "task_url": "https://app.asana.com/0/1200000000000000/1201234567890123",
  "created_at": "2026-02-14T10:30:00.000Z",
  "error": null
}
```

## File Structure

```
asana-create-task/
├── run.xs                           # Run job definition
├── function/
│   └── create_asana_task.xs         # Function implementation
└── README.md                        # This file
```

## API Reference

This integration uses the Asana REST API:
- Documentation: https://developers.asana.com/docs
- Endpoint: `POST /tasks`

## Error Handling

The function validates:
- ASANA_ACCESS_TOKEN is configured
- Task name is provided
- Project ID is provided

API errors are returned with descriptive messages from the Asana API.

## Rate Limits

Asana API has rate limits. See Asana documentation for current limits:
https://developers.asana.com/docs/rate-limits
