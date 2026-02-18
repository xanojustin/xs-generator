# GitHub Create Issue - Xano Run Job

This Xano Run Job creates an issue in a GitHub repository using the [GitHub REST API](https://docs.github.com/en/rest) and logs the result to a database table.

## What It Does

1. Accepts repository information (owner, name) and issue details (title, body, labels)
2. Creates an issue via GitHub's REST API
3. Logs the created issue (or failure) to the `issue_log` table
4. Returns the issue number, URL, and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `GITHUB_TOKEN` | Your GitHub personal access token (get from https://github.com/settings/tokens) |

**Token Permissions Required:**
- `repo` scope for private repositories
- `public_repo` scope for public repositories

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "GitHub Create Issue"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "GitHub Create Issue" {
  main = {
    name: "create_github_issue"
    input: {
      repo_owner: "myorg"
      repo_name: "myrepo"
      title: "Bug: Login button not working"
      body: "Users report they cannot click the login button on mobile devices."
      labels: ["bug", "mobile", "urgent"]
    }
  }
  env = ["GITHUB_TOKEN"]
}
```

### Function Inputs

The `create_github_issue` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `repo_owner` | text | Yes | - | Repository owner (username or organization) |
| `repo_name` | text | Yes | - | Repository name |
| `title` | text | Yes | - | Issue title |
| `body` | text | No | `""` | Issue body/description (supports Markdown) |
| `labels` | text[] | No | `[]` | Array of label names to apply to the issue |

### Response (Success)

```json
{
  "success": true,
  "issue_number": 42,
  "issue_title": "Found a bug",
  "issue_url": "https://github.com/octocat/Hello-World/issues/42",
  "github_issue_id": "1234567890",
  "log_id": 1
}
```

### Response (Error)

If the GitHub API returns an error:

```json
{
  "name": "GitHubError",
  "value": "GitHub API error: Not Found"
}
```

Common errors:
- `404 Not Found` - Repository doesn't exist or you don't have access
- `403 Forbidden` - Token doesn't have required permissions
- `422 Validation Failed` - Invalid label names or other validation errors

## Files

- `run.xs` - Run job configuration
- `function/create_github_issue.xs` - Issue creation logic
- `table/issue_log.xs` - Database table for logging issues

## Notes

- The GitHub API returns a 201 status code on successful creation
- All issues (successful and failed) are logged to `issue_log`
- Labels must already exist in the repository - GitHub won't create new labels automatically
- The token must have write access to the repository to create issues
