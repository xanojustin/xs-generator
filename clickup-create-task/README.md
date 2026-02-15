# ClickUp Create Task

A Xano Run Job that creates tasks in ClickUp via the ClickUp API v2.

## What This Run Job Does

This run job creates a new task in a specified ClickUp list with support for:
- Task name and description
- Assignee assignment (by ClickUp user ID)
- Due dates
- Priority levels (1=Urgent, 2=High, 3=Normal, 4=Low)
- Tags

## Required Environment Variables

| Variable | Description | Where to Find |
|----------|-------------|---------------|
| `clickup_api_key` | Your ClickUp API token | ClickUp Settings → Apps → Generate API Token |
| `clickup_team_id` | Your ClickUp Team ID | ClickUp Settings → Workspaces → Copy the ID from URL |

## How to Use

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `list_id` | text | Yes | - | ClickUp List ID where the task will be created |
| `task_name` | text | Yes | - | Name/title of the task |
| `task_description` | text | No | - | Task description/body |
| `assignee_ids` | json | No | [] | Array of ClickUp user IDs to assign |
| `due_date` | text | No | - | Due date (ISO 8601 format recommended) |
| `priority` | int | No | 3 | Priority: 1=Urgent, 2=High, 3=Normal, 4=Low |
| `tags` | json | No | [] | Array of tag names to apply |

### Example Usage

```json
{
  "list_id": "123456789",
  "task_name": "Review Q4 Marketing Plan",
  "task_description": "Please review the attached marketing plan for Q4.",
  "assignee_ids": [123456, 789012],
  "due_date": "2025-03-15",
  "priority": 2,
  "tags": ["urgent", "marketing"]
}
```

### Response

```json
{
  "success": true,
  "task_id": "abc123def456",
  "task_name": "Review Q4 Marketing Plan",
  "url": "https://app.clickup.com/t/abc123def456",
  "created_at": "2025-02-15T17:15:00Z"
}
```

## File Structure

```
clickup-create-task/
├── run.xs                          # Run job configuration
├── function/
│   └── create_clickup_task.xs      # Function implementation
└── README.md                       # This file
```

## ClickUp API Reference

- [ClickUp API Documentation](https://clickup.com/api)
- [Create Task Endpoint](https://clickup.com/api/clickupreference/operation/CreateTask/)

## Notes

- The due_date is converted to milliseconds since epoch for the ClickUp API
- Priority values must be 1 (Urgent), 2 (High), 3 (Normal), or 4 (Low)
- Assignee IDs are ClickUp user IDs, not email addresses
- Tags must already exist in your ClickUp workspace to be applied
