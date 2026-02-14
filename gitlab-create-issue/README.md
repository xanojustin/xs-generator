# GitLab Create Issue Run Job

This XanoScript run job creates a new issue in a GitLab project using the GitLab API.

## What It Does

This run job creates a GitLab issue with the following capabilities:

- Creates an issue in a specified GitLab project
- Supports setting a title, description, and labels
- Optionally assigns the issue to a specific user
- Optionally assigns the issue to a milestone
- Returns the issue ID, URL, and other details
- Works with GitLab.com or self-hosted GitLab instances

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `GITLAB_TOKEN` | Your GitLab personal access token (with `api` scope) |
| `GITLAB_BASE_URL` | Base URL of your GitLab instance (default: `https://gitlab.com`) |

### Creating a GitLab Personal Access Token

1. Go to GitLab → User Settings → Access Tokens
2. Create a token with the `api` scope
3. Copy the token and set it as `GITLAB_TOKEN`

## How to Use

### Run the Job

The job is configured with example values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `project_id` | text | Yes | GitLab project ID (e.g., `12345678`) or URL-encoded path (e.g., `group%2Fproject`) |
| `title` | text | Yes | Title of the issue |
| `description` | text | No | Description of the issue (supports GitLab Markdown) |
| `labels` | text | No | Comma-separated label names (e.g., `bug,critical`) |
| `assignee_id` | text | No | User ID to assign the issue to |
| `milestone_id` | text | No | Milestone ID to assign the issue to |

### Response

```json
{
  "success": true,
  "issue_id": 123456789,
  "issue_iid": 42,
  "issue_url": "https://gitlab.com/group/project/-/issues/42",
  "state": "opened",
  "created_at": "2024-01-15T10:30:00.000Z",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "issue_id": null,
  "issue_iid": null,
  "issue_url": null,
  "state": null,
  "created_at": null,
  "error": "Project not found"
}
```

## File Structure

```
gitlab-create-issue/
├── run.xs                    # Run job definition
├── function/
│   └── create_issue.xs       # Function to create GitLab issue
└── README.md                 # This file
```

## GitLab API Reference

- [Issues API](https://docs.gitlab.com/ee/api/issues.html#new-issue)
- [Personal Access Tokens](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
- [Project ID](https://docs.gitlab.com/ee/api/index.html#project-id)

## Finding Your Project ID

1. Go to your GitLab project
2. Look under Settings → General → Project ID
3. Or use the URL-encoded path: `namespace/project` → `namespace%2Fproject`

## Testing

Use GitLab's test instances or a personal project for testing:
1. Create a personal access token
2. Get your project ID
3. Run the job with test values

## Security Notes

- Never commit your `GITLAB_TOKEN` to version control
- Use tokens with minimal required permissions
- Rotate tokens regularly
- For self-hosted GitLab, ensure HTTPS is used
