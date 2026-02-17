# Jira Create Issue - Xano Run Job

A Xano Run Job that creates issues in Atlassian Jira using the Jira REST API v3.

## What This Run Job Does

This run job creates a new issue in a specified Jira project with support for:
- Setting issue summary, type, priority
- Adding formatted descriptions using Atlassian Document Format (ADF)
- Error handling with specific error messages for common failure cases
- Returns the created issue key, ID, and URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `JIRA_BASE_URL` | Your Jira instance URL | `https://your-domain.atlassian.net` |
| `JIRA_API_TOKEN` | Your Jira API token | Create at: https://id.atlassian.com/manage-profile/security/api-tokens |
| `JIRA_USER_EMAIL` | The email associated with your Jira account | `user@example.com` |

## How to Use

### Basic Usage

```xs
run.job "Jira Create Issue" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "PROJ"
      summary: "Fix login bug"
      issue_type: "Bug"
    }
  }
}
```

### With All Optional Parameters

```xs
run.job "Jira Create Issue" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "PROJ"
      summary: "Implement user authentication"
      issue_type: "Story"
      description: "As a user, I want to log in with my email..."
      priority: "High"
      assignee: "user@example.com"
    }
  }
}
```

### Available Issue Types

Common Jira issue types include:
- `Bug` - Something isn't working
- `Story` - New feature or functionality
- `Task` - General task
- `Epic` - Large body of work
- `Subtask` - Smaller piece of a larger task

### Available Priority Levels

- `Highest`
- `High`
- `Medium`
- `Low`
- `Lowest`

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "issue_key": "PROJ-123",
  "issue_id": "10001",
  "self_url": "https://your-domain.atlassian.net/rest/api/3/issue/10001",
  "message": "Issue PROJ-123 created successfully"
}
```

## Error Handling

The run job handles these specific error cases:

| HTTP Status | Error Type | Description |
|-------------|------------|-------------|
| 400 | `JiraValidationError` | Invalid input data or missing required fields |
| 401 | `JiraAuthError` | Invalid API token or email |
| 403 | `JiraPermissionError` | User lacks permission to create issues in this project |
| 404 | `JiraNotFoundError` | Project not found or inaccessible |

## File Structure

```
~/xs/jira-create-issue/
├── run.xs                      # Run job definition
├── function/
│   └── create_jira_issue.xs    # Function that calls Jira API
└── README.md                   # This file
```

## Setting Up Your Jira API Token

1. Log in to your Atlassian account: https://id.atlassian.com
2. Go to **Security** > **Create and manage API tokens**
3. Click **Create API token**
4. Give it a name (e.g., "Xano Integration")
5. Copy the token immediately (it won't be shown again)
6. Set it as `JIRA_API_TOKEN` in your environment variables

## API Reference

This run job uses the Jira REST API v3:
- **Endpoint**: `POST /rest/api/3/issue`
- **Documentation**: https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-post

## Troubleshooting

### "Project 'XXX' not found"
- Verify the `project_key` is correct (not the project name)
- Ensure your Jira account has access to view the project

### "Authentication failed"
- Verify your `JIRA_API_TOKEN` is valid and not expired
- Ensure `JIRA_USER_EMAIL` matches the email for your Atlassian account
- Check that your `JIRA_BASE_URL` is correct (include `https://`)

### "Permission denied"
- Your Jira account needs "Create Issues" permission in the target project
- Check project permissions in Jira: Project Settings > Permissions

## License

MIT - Part of the Xano Run Job collection
