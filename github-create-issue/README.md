# GitHub Create Issue Run Job

This XanoScript run job creates issues in GitHub repositories via the GitHub REST API.

## What It Does

This run job creates a new issue in a specified GitHub repository. It handles:

- Creating issues with title and body
- Assigning labels to issues
- Assigning users to issues
- Returning issue details including the URL
- Proper error handling for API failures

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `GITHUB_TOKEN` | Your GitHub personal access token (classic) or fine-grained token |

### Token Permissions Required

Your GitHub token needs the following permissions:
- **Classic tokens**: `repo` scope (for private repos) or `public_repo` (for public repos only)
- **Fine-grained tokens**: `Issues` read/write access for the target repository

## How to Use

### Run the Job

The job is configured with example values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `owner` | text | Yes | Repository owner (username or organization) |
| `repo` | text | Yes | Repository name |
| `title` | text | Yes | Issue title |
| `body` | text | No | Issue body/description (supports Markdown) |
| `labels` | text | No | Comma-separated list of label names (e.g., `"bug,urgent"`) |
| `assignees` | text | No | Comma-separated list of GitHub usernames (e.g., `"octocat,monalisa"`) |

### Response

```json
{
  "success": true,
  "issue_number": 42,
  "issue_url": "https://api.github.com/repos/octocat/Hello-World/issues/42",
  "issue_html_url": "https://github.com/octocat/Hello-World/issues/42",
  "state": "open",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "issue_number": null,
  "issue_url": null,
  "issue_html_url": null,
  "state": null,
  "error": "Not Found"
}
```

## File Structure

```
github-create-issue/
├── run.xs                         # Run job definition
├── function/
│   └── create_github_issue.xs     # Function to create GitHub issues
├── README.md                      # This file
└── FEEDBACK.md                    # Development feedback
```

## GitHub API Reference

- [GitHub REST API - Create an issue](https://docs.github.com/en/rest/issues/issues#create-an-issue)
- [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

## Testing

To test this run job:

1. Create a GitHub personal access token with `repo` or `public_repo` scope
2. Set the `GITHUB_TOKEN` environment variable
3. Run the job with a repository you have access to
4. Check that the issue appears in the target repository

## Security Notes

- Never commit your `GITHUB_TOKEN` to version control
- Use fine-grained tokens with minimal required permissions when possible
- The token should only have access to repositories where issue creation is needed
- Consider using GitHub Apps for production scenarios with broader access needs
