# Jira Create Issue - Xano Run Job

This Xano Run Job creates a new issue in Jira using the Jira REST API v2.

## What It Does

The run job calls a function that creates a Jira issue with the following capabilities:
- Creates issues in any Jira project
- Supports customizable issue types (Task, Bug, Story, Epic, etc.)
- Allows setting summary, description, and priority
- Supports adding labels to issues
- Returns the created issue key, ID, and URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `JIRA_BASE_URL` | Your Jira instance base URL | `https://your-domain.atlassian.net` |
| `JIRA_EMAIL` | Your Atlassian account email | `user@example.com` |
| `JIRA_API_TOKEN` | Your Jira API token | `your-api-token-here` |

### How to Get a Jira API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Give it a name (e.g., "Xano Integration")
4. Copy the token immediately (it won't be shown again)

## Usage

### Basic Usage (Default Settings)

The run job comes with default input values. To use it:

1. Set the environment variables in your Xano workspace
2. Update the `input` values in `run.xs` with your desired issue details
3. Deploy and run the job

### Custom Input Parameters

You can customize the following input parameters:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `project_key` | text | Yes | `"PROJ"` | The Jira project key (e.g., "PROJ", "DEV", "SUPPORT") |
| `summary` | text | Yes | - | The issue summary/title |
| `issue_type` | text | No | `"Task"` | Issue type: Task, Bug, Story, Epic, etc. |
| `description` | text | No | - | Detailed description of the issue |
| `priority` | text | No | - | Priority: Highest, High, Medium, Low, Lowest |
| `labels` | text[] | No | - | Array of labels to apply |

### Example: Create a Bug Report

```xs
run.job "Jira Create Bug" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "BUG"
      summary: "Critical login error on mobile"
      issue_type: "Bug"
      description: "Users are unable to log in using mobile devices. Error occurs on iOS and Android."
      priority: "High"
      labels: ["mobile", "login", "critical"]
    }
  }
  env = ["JIRA_BASE_URL", "JIRA_EMAIL", "JIRA_API_TOKEN"]
}
```

### Example: Create a User Story

```xs
run.job "Jira Create Story" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "PROJ"
      summary: "As a user, I want to export reports to PDF"
      issue_type: "Story"
      description: "Allow users to export their analytics reports as PDF documents."
      priority: "Medium"
    }
  }
  env = ["JIRA_BASE_URL", "JIRA_EMAIL", "JIRA_API_TOKEN"]
}
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "issue_key": "PROJ-123",
  "issue_id": "10001",
  "issue_url": "https://your-domain.atlassian.net/browse/PROJ-123",
  "message": "Issue created successfully"
}
```

## File Structure

```
jira-create-issue/
├── run.xs                    # Run job configuration
├── function/
│   └── create_jira_issue.xs  # Function that calls Jira API
└── README.md                 # This file
```

## Error Handling

The function includes validation and will throw errors for:
- Missing required environment variables
- Invalid Jira credentials
- Non-existent project keys
- API request failures (returns status code and error message)

## Notes

- The Jira API uses Basic Authentication with your email and API token
- Issue types must exist in your Jira project (check your project settings)
- Priority values must match your Jira instance's configured priorities
- Labels are optional and can be any string values

## Resources

- [Jira REST API v2 Documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v2/)
- [Create API Token](https://id.atlassian.com/manage-profile/security/api-tokens)
