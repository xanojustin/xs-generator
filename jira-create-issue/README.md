# Jira Create Issue - Xano Run Job

This Xano Run Job creates a new issue in Jira using the Jira REST API v3.

## What It Does

The run job executes a function that creates a Jira issue with configurable properties:
- Project key (required)
- Issue summary/title (required)
- Description (optional, supports Atlassian Document Format)
- Issue type: Task, Bug, Story, Epic (default: Task)
- Priority: Highest, High, Medium, Low, Lowest (optional)
- Assignee by account ID (optional)
- Labels (optional array)

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `jira_base_url` | Your Jira instance base URL | `https://your-domain.atlassian.net` |
| `jira_api_token` | Base64 encoded email:API token for Basic Auth | `base64(email:token)` |

### Setting up Jira API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Give it a name (e.g., "Xano Integration")
4. Copy the token

### Creating the Base64 Auth String

Your `jira_api_token` environment variable should be a Base64-encoded string of `your-email@example.com:your-api-token`:

```bash
# On macOS/Linux:
echo -n "your-email@example.com:your-api-token" | base64

# Or use an online base64 encoder
```

The header sent will be: `Authorization: Basic <base64-encoded-string>`

## Folder Structure

```
jira-create-issue/
├── run.xs              # Run job configuration
├── function/
│   └── jira_create_issue.xs  # Function that creates the issue
└── README.md           # This file
```

## How to Use

### Running the Job

With the Xano CLI:
```bash
xano run execute --job "Jira Create Issue"
```

Or via the Xano Run API.

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "Jira Create Issue" {
  main = {
    name: "jira_create_issue"
    input: {
      project_key: "YOURPROJECT"
      summary: "Bug: User cannot login"
      description: "Detailed description here..."
      issue_type: "Bug"
      priority: "High"
      assignee_account_id: "5f8a9b2c..."
      labels: ["bug", "urgent", "backend"]
    }
  }
  env = ["jira_base_url", "jira_api_token"]
}
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "issue_key": "PROJ-123",
  "issue_id": "10001",
  "self_url": "https://your-domain.atlassian.net/rest/api/3/issue/10001",
  "message": "Issue created successfully: PROJ-123"
}
```

## Error Handling

The function validates the API response and throws a `JiraAPIError` if:
- The Jira API returns a non-2xx status code
- Required fields are missing or invalid
- Authentication fails

## API Reference

- [Jira REST API v3 - Create Issue](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-post)
- [Jira REST API v3 - ADF (Atlassian Document Format)](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/)

## License

MIT
