# Asana Create Task - Xano Run Job

This Xano Run Job creates a new task in an Asana project using the Asana API. It demonstrates how to integrate with Asana's project management service from Xano.

## What This Run Job Does

The `Asana Create Task` run job creates tasks by:
1. Accepting task details (name, project ID, notes, optional assignee and due date)
2. Making an authenticated request to Asana's `/api/1.0/tasks` endpoint
3. Returning the created task object with details like task ID, name, and permalink URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `asana_access_token` | Your Asana Personal Access Token | `1/1234567890:abcdef123456...` |

### Getting Your Asana Access Token

1. Log in to your [Asana Developer Console](https://app.asana.com/0/developer-console)
2. Click on **+ New Access Token**
3. Give your token a name (e.g., "Xano Integration")
4. Copy the generated token immediately (it won't be shown again)

### Getting Your Project ID

1. Open your Asana project in the web interface
2. Look at the URL: `https://app.asana.com/0/PROJECT_ID/TASK_ID`
3. The `PROJECT_ID` is the long number in the URL path

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Asana Create Task"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Asana Create Task"
}
```

### Customizing the Task

Edit the `input` block in `run.xs`:

```xs
run.job "Asana Create Task" {
  main = {
    name: "asana_create_task"
    input: {
      name: "Review Q4 Marketing Plan"              // Task title
      project_id: "1234567890"                       // Your project GID
      notes: "Please review the attached document"  // Task description
      assignee: "1234567890"                         // Assignee user GID (optional)
      due_date: "2025-02-28"                         // Due date YYYY-MM-DD (optional)
    }
  }
  env = ["asana_access_token"]
}
```

### Getting User GID for Assignee

1. Make a request to `GET /api/1.0/users?workspace=WORKSPACE_ID`
2. Or find the user GID in Asana URLs when viewing a user's profile

## File Structure

```
asana-create-task/
├── run.xs                    # Run job configuration
├── function/
│   └── asana_create_task.xs  # Function that calls Asana API
└── README.md                 # This file
```

## Response Format

On success, the function returns an Asana Task object:

```json
{
  "gid": "1234567890",
  "name": "Review Q4 Marketing Plan",
  "resource_type": "task",
  "resource_subtype": "default_task",
  "created_at": "2025-02-16T22:45:00.000Z",
  "modified_at": "2025-02-16T22:45:00.000Z",
  "notes": "Please review the attached document",
  "assignee": {
    "gid": "1234567890",
    "resource_type": "user",
    "name": "John Doe"
  },
  "assignee_status": "inbox",
  "completed": false,
  "completed_at": null,
  "due_on": "2025-02-28",
  "due_at": null,
  "projects": [
    {
      "gid": "1234567890",
      "resource_type": "project",
      "name": "Marketing Campaigns"
    }
  ],
  "workspace": {
    "gid": "1234567890",
    "resource_type": "workspace",
    "name": "My Company"
  },
  "permalink_url": "https://app.asana.com/0/1234567890/1234567890"
}
```

## Error Handling

The function throws an `AsanaAPIError` if:
- The Asana API returns a non-2xx status code
- The request times out
- Authentication fails (invalid access token)
- The project ID doesn't exist or you don't have access
- Required fields are missing

## Security Notes

- **Never commit your Asana access token** - always use environment variables
- Use a dedicated service account token rather than your personal token for production
- Store tokens securely in Xano's environment variable management
- The token provides full access to your Asana account - protect it accordingly

## Asana API Limitations

- Rate limit: 1500 requests per minute per user
- See [Asana API documentation](https://developers.asana.com/docs) for more details

## Additional Resources

- [Asana API Documentation](https://developers.asana.com/docs)
- [Asana Developer Console](https://app.asana.com/0/developer-console)
- [XanoScript Documentation](https://docs.xano.com)
