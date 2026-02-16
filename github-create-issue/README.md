# GitHub Create Issue - Xano Run Job

This Xano Run Job creates an issue in a GitHub repository using the GitHub REST API. It demonstrates how to integrate with GitHub's issue tracking service from Xano.

## What This Run Job Does

The `GitHub Create Issue` run job creates a new issue by:
1. Accepting repository details (owner, repo name) and issue data (title, body, labels)
2. Making an authenticated POST request to GitHub's `/repos/{owner}/{repo}/issues` endpoint
3. Returning the created issue object with details like issue number, URL, and creation timestamp

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `github_token` | Your GitHub Personal Access Token | `ghp_xxxxxxxxxxxxxxxxxxxx` |

### Getting Your GitHub Personal Access Token

1. Log in to your [GitHub account](https://github.com)
2. Go to Settings → Developer settings → Personal access tokens → Tokens (classic)
3. Click "Generate new token (classic)"
4. Give it a descriptive name like "Xano Run Job"
5. Select the `repo` scope (for private repos) or `public_repo` (for public repos only)
6. Click "Generate token"
7. **Copy the token immediately** - you won't be able to see it again!

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "GitHub Create Issue"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "GitHub Create Issue"
}
```

### Customizing the Issue

Edit the `input` block in `run.xs`:

```xs
run.job "GitHub Create Issue" {
  main = {
    name: "github_create_issue"
    input: {
      owner: "myusername"           // GitHub username or org
      repo: "my-repository"         // Repository name
      title: "Bug: Login not working"  // Issue title
      body: "## Description\n\nUsers cannot log in..."  // Issue body (Markdown supported)
      labels: ["bug", "high-priority"]  // Labels to apply
    }
  }
  env = ["github_token"]
}
```

## File Structure

```
github-create-issue/
├── run.xs                          # Run job configuration
├── function/
│   └── github_create_issue.xs      # Function that calls GitHub API
├── README.md                       # This file
└── FEEDBACK.md                     # Development feedback for MCP improvements
```

## Response Format

On success, the function returns a GitHub Issue object:

```json
{
  "id": 1,
  "node_id": "MDU6SXNzdWUx",
  "url": "https://api.github.com/repos/octocat/Hello-World/issues/1347",
  "repository_url": "https://api.github.com/repos/octocat/Hello-World",
  "labels_url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/labels{/name}",
  "comments_url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/comments",
  "events_url": "https://api.github.com/repos/octocat/Hello-World/issues/1347/events",
  "html_url": "https://github.com/octocat/Hello-World/issues/1347",
  "number": 1347,
  "state": "open",
  "title": "Test issue created from Xano Run Job",
  "body": "This issue was created automatically using the Xano Run Job for the GitHub API.",
  "user": {
    "login": "octocat",
    "id": 1,
    "node_id": "MDQ6VXNlcjE=",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "gravatar_id": "",
    "url": "https://api.github.com/users/octocat",
    "html_url": "https://github.com/octocat",
    "type": "User"
  },
  "labels": [
    {
      "id": 208045946,
      "node_id": "MDU6TGFiZWwyMDgwNDU5NDY=",
      "url": "https://api.github.com/repos/octocat/Hello-World/labels/bug",
      "name": "bug",
      "description": "Something isn't working",
      "color": "d73a4a",
      "default": true
    }
  ],
  "assignee": null,
  "assignees": [],
  "milestone": null,
  "locked": false,
  "active_lock_reason": null,
  "comments": 0,
  "pull_request": null,
  "closed_at": null,
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z",
  "closed_by": null
}
```

## Error Handling

The function throws a `GitHubAPIError` if:
- The GitHub API returns a non-2xx status code
- The request times out
- Authentication fails (invalid or expired token)
- The repository doesn't exist
- You don't have permission to create issues in the repository
- Rate limiting is exceeded (GitHub allows 5000 requests per hour for authenticated users)

### Common Error Codes

| Status Code | Meaning |
|-------------|---------|
| 401 | Bad credentials - check your token |
| 403 | Forbidden - insufficient permissions or rate limited |
| 404 | Repository not found |
| 422 | Validation failed - check your input data |

## Security Notes

- **Never commit your GitHub token** - always use environment variables
- Use fine-grained personal access tokens with minimal required permissions
- Rotate your tokens regularly
- For production use, consider using GitHub Apps instead of personal access tokens
- The `repo` scope grants significant access - use `public_repo` if you only need public repository access

## Additional Resources

- [GitHub REST API Documentation - Issues](https://docs.github.com/en/rest/issues/issues#create-an-issue)
- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [GitHub Apps vs OAuth Apps](https://docs.github.com/en/developers/apps/getting-started-with-apps/differences-between-github-apps-and-oauth-apps)
- [XanoScript Documentation](https://docs.xano.com)