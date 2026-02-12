# GitHub Create Issue Run Job

A XanoScript run job that creates issues in GitHub repositories via the GitHub REST API.

## What It Does

This run job creates a new issue in a specified GitHub repository with:
- **Custom title** - The issue headline
- **Optional body** - Detailed description (supports Markdown)
- **Optional labels** - JSON array of label names to apply
- **Optional assignees** - JSON array of GitHub usernames to assign

Perfect for automated bug reporting, feature request submission, or integrating GitHub issues into your workflow.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `github_token` | Your GitHub Personal Access Token (classic or fine-grained) |

### Creating a GitHub Token

1. Go to: https://github.com/settings/tokens
2. Click **Generate new token** (classic) or **Generate new token** (fine-grained)
3. For classic tokens, select the `repo` scope (full control of private repositories)
4. For fine-grained tokens, select your target repository and grant **Issues** read/write access
5. Copy the generated token

**Security Note:** Keep your token secure. It grants access to your GitHub account. Never commit it to version control.

## How to Use

### 1. Set the Environment Variable

```bash
export github_token="ghp_your_token_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Issue

Edit the `input` block in `run.xs` to customize:

```xs
run.job "GitHub Create Issue" {
  main = {
    name: "github_create_issue"
    input: {
      repo_owner: "myorg"
      repo_name: "myrepo"
      title: "Bug: User login fails on Safari"
      body: "## Description\n\nUsers report login failures when using Safari browser.\n\n## Steps to Reproduce\n\n1. Open Safari\n2. Navigate to login page\n3. Enter credentials\n4. Click login"
      labels_json: "[\"bug\", \"high-priority\", \"safari\"]"
      assignees_json: "[\"developer1\", \"developer2\"]"
    }
  }
  env = ["github_token"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `repo_owner` | text | Yes | GitHub username or organization that owns the repository |
| `repo_name` | text | Yes | Name of the repository |
| `title` | text | Yes | Title of the issue |
| `body` | text | No | Body content of the issue (Markdown supported) |
| `labels_json` | text | No | JSON array string of label names (e.g., `'["bug", "help wanted"]'`) |
| `assignees_json` | text | No | JSON array string of GitHub usernames (e.g., `'["octocat"]'`) |

### Label Requirements

Labels must already exist in the repository. The API will return an error if you try to apply a non-existent label.

Common default labels: `bug`, `duplicate`, `enhancement`, `help wanted`, `invalid`, `question`, `wontfix`

### Assignee Requirements

Assignees must have push access to the repository. You cannot assign issues to users who don't have appropriate permissions.

## File Structure

```
github-create-issue/
├── run.xs                              # Run job configuration
├── functions/
│   └── github_create_issue.xs          # Function that calls GitHub API
└── README.md                           # This file
```

## API Reference

This implementation uses the GitHub REST API:

### Create an Issue
- Endpoint: `POST https://api.github.com/repos/{owner}/{repo}/issues`
- Documentation: https://docs.github.com/en/rest/issues/issues#create-an-issue

## Response

On success, the function returns:

```json
{
  "success": true,
  "issue_number": 42,
  "issue_url": "https://github.com/octocat/Hello-World/issues/42",
  "issue_id": 1234567890,
  "title": "Test Issue from Xano",
  "state": "open",
  "created_at": "2024-01-15T10:30:00Z"
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (repo_owner, repo_name, title)
- Missing environment variable (github_token)
- Invalid repository (not found or no access)
- Invalid labels (label doesn't exist in the repo)
- Invalid assignees (user doesn't have push access)
- Authentication errors (invalid or expired token)
- Rate limiting (GitHub API rate limits apply)

## Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `Not Found` | Repository doesn't exist or token lacks access | Check repo_owner/repo_name spelling; verify token permissions |
| `Validation Failed` | Label doesn't exist or assignee lacks permissions | Ensure labels exist in the repo; verify assignees have push access |
| `Bad credentials` | Invalid or expired token | Generate a new token |
| `Abuse rate limit` | Too many requests | Wait and retry; consider implementing backoff |

## Rate Limits

GitHub API rate limits apply:
- **Authenticated requests**: 5,000 requests per hour
- **Unauthenticated requests**: 60 requests per hour

This job uses authenticated requests (with your token), so you get 5,000/hour.

## License

MIT