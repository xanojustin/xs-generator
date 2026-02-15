# Toggl Start Timer Run Job

This XanoScript run job starts a new time entry in Toggl Track (time tracking application).

## What It Does

This run job creates a new running time entry in Toggl Track. It handles:

- Starting a timer with a description
- Setting billable/non-billable status
- Associating the entry with a project (optional)
- Adding tags to the entry (optional)
- Returning the time entry ID and start time

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `TOGGL_API_TOKEN` | Your Toggl API token (found in Profile Settings) |
| `TOGGL_EMAIL` | Your Toggl account email address |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | text | Yes | Your Toggl workspace ID (found in URL when logged in) |
| `description` | text | Yes | Description of what you're working on |
| `billable` | text | No | Set to "true" for billable time (default: "false") |
| `project_id` | text | No | Optional project ID to associate with the entry |
| `tags` | text | No | Optional comma-separated list of tags (e.g., "client-work,urgent") |

### Response

```json
{
  "success": true,
  "time_entry_id": 1234567890,
  "description": "Working on XanoScript project",
  "workspace_id": "1234567",
  "start_time": "2024-01-15T14:30:00.000Z",
  "duration": -1,
  "running": true,
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "time_entry_id": null,
  "description": "Working on XanoScript project",
  "workspace_id": "1234567",
  "start_time": null,
  "duration": null,
  "running": false,
  "error": "Invalid workspace ID"
}
```

## File Structure

```
toggl-start-timer/
├── run.xs                         # Run job definition
├── function/
│   └── start_time_entry.xs        # Function to start time entry
├── README.md                      # This file
└── FEEDBACK.md                    # MCP/XanoScript feedback
```

## Toggl API Reference

- [Toggl Track API Documentation](https://engineering.toggl.com/docs/)
- [Time Entries API](https://engineering.toggl.com/docs/api/time_entries/)
- [Tracking Guide](https://engineering.toggl.com/docs/tracking/)

## Getting Your Credentials

### API Token
1. Log in to Toggl Track
2. Go to Profile Settings
3. Scroll down to "API Token"
4. Copy the token

### Workspace ID
1. Log in to Toggl Track
2. The workspace ID is in the URL: `https://track.toggl.com/timer/<workspace_id>`

### Project ID
1. Go to Projects in Toggl Track
2. Click on a project
3. The project ID is in the URL or can be fetched via API

## Notes

- A running time entry has `duration: -1` and `stop: null`
- The timer will continue running until stopped via the Toggl web app, mobile app, or API
- You can only have one running time entry at a time per workspace
