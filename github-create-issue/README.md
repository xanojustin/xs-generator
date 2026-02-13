# GitHub Create Issue - Xano Run Job

This Xano run job creates an issue in a GitHub repository using the GitHub REST API.

## What It Does

The run job executes a function that creates a new GitHub issue in a specified repository. It handles:

- Authentication with GitHub using a Personal Access Token
- Creating issues with title and optional body
- Returning detailed issue information including URL and issue number

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `github_token` | GitHub Personal Access Token | `ghp_xxxxxxxxxxxxxxxxxxxx` |
| `github_owner` | Repository owner (user or organization) | `octocat` |
| `github_repo` | Repository name | `Hello-World` |
| `github_issue_title` | Title of the issue to create | `Bug: Login not working` |

## Optional Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `github_issue_body` | Body content of the issue (supports Markdown) | `null` (empty body) |

## How to Use

### 1. Create a GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Select the `repo` scope (for private repos) or `public_repo` (for public repos)
4. Copy the generated token

### 2. Set Environment Variables

Configure the required environment variables in your Xano workspace settings.

### 3. Run the Job

Execute the run job using the Xano CLI or dashboard:

```bash
xano run execute github-create-issue
```

### 4. Customize the Issue

Set the `github_issue_title` and optionally `github_issue_body` to create your issue:

```bash
# Example with custom title and body
github_issue_title="Feature Request: Add dark mode"
github_issue_body="It would be great to have a dark mode option in the settings."
```

## File Structure

```
github-create-issue/
├── run.xs                      # Run job configuration
├── function/
│   └── create_issue.xs         # Issue creation function
├── README.md                   # This file
└── FEEDBACK.md                 # Development feedback for MCP improvements
```

## GitHub API Reference

- **Endpoint**: `POST https://api.github.com/repos/{owner}/{repo}/issues`
- **Auth**: Bearer Token (Personal Access Token)
- **Headers**:
  - `Accept: application/vnd.github+json`
  - `X-GitHub-Api-Version: 2022-11-28`
  - `Authorization: Bearer {token}`
- **Parameters**:
  - `title`: Issue title (required)
  - `body`: Issue body in Markdown (optional)

## Response Format

### Success

```json
{
  "status": "success",
  "message": "Issue created successfully",
  "issue_number": 42,
  "issue_id": 1234567890,
  "issue_url": "https://github.com/octocat/Hello-World/issues/42",
  "title": "Bug: Login not working",
  "state": "open",
  "created_at": "2024-01-15T10:30:00Z",
  "github_response": { ... }
}
```

### Error

```json
{
  "status": "error",
  "message": "Failed to create issue. Status: 401, Error: Bad credentials",
  "github_response": { ... }
}
```

## Common Error Codes

| Status | Meaning | Solution |
|--------|---------|----------|
| 401 | Bad credentials | Check your `github_token` |
| 403 | Forbidden | Token lacks `repo` scope or rate limited |
| 404 | Not Found | Check `github_owner` and `github_repo` |
| 410 | Gone | Repository issues are disabled |
| 422 | Validation Failed | Check issue title is not empty |

## Security Notes

- Never expose your GitHub token in client-side code
- Use fine-grained personal access tokens with minimal required permissions
- Store the token as an environment variable, never hardcode it
- Consider using GitHub App tokens for production applications

## Testing

Use a test repository to verify the integration works before using in production.

## Notes

- The issue will be created as the user who owns the Personal Access Token
- You can include Markdown formatting in the `github_issue_body`
- Rate limits apply: 5,000 requests per hour for authenticated users
- The created issue will be open by default