# Linear Create Issue Run Job

This Xano Run Job creates a new issue in Linear using their GraphQL API.

## What It Does

Creates a new issue in Linear with:
- **Title** - The issue title (required)
- **Description** - Issue description/body (optional)
- **Team** - Target team by key (e.g., "ENG", "PROD")

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `linear_api_key` | Your Linear API key (Personal Access Token) |

### Getting a Linear API Key

1. Go to Linear → Settings → API → Personal API keys
2. Create a new key with appropriate permissions
3. Copy the key and set it as `linear_api_key` environment variable

## Usage

### Basic Usage (Default values)

The run job will create an issue with default values defined in `run.xs`.

### Custom Input

You can override the default inputs when triggering the run job:

```json
{
  "title": "Bug: Login button not working",
  "description": "Users report the login button is unresponsive on mobile.",
  "team_key": "ENG"
}
```

## File Structure

```
linear-create-issue/
├── run.xs              # Run job configuration
├── function/
│   └── create_issue.xs # Issue creation logic
└── README.md           # This file
```

## Response

On success, returns:

```json
{
  "success": true,
  "issue_id": "issue-uuid-here",
  "identifier": "ENG-123",
  "title": "Bug: Login button not working",
  "url": "https://linear.app/team/issue/ENG-123",
  "state": "Backlog"
}
```

## Error Handling

The run job handles these error cases:
- Missing API key → `AuthenticationError`
- Invalid API key → `AuthenticationError` (401)
- Missing required fields → `inputerror`
- GraphQL errors → `LinearAPIError`
- API failures → `APIError`

## API Reference

Uses the Linear GraphQL API:
- **Endpoint**: `https://api.linear.app/graphql`
- **Authentication**: Bearer token (API key)
- **Documentation**: https://developers.linear.app/docs/graphql/working-with-the-graphql-api
