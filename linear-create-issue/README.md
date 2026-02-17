# Linear Create Issue - Xano Run Job

This Xano Run Job creates an issue in Linear using their GraphQL API. Linear is a popular issue tracking and project management tool designed for software teams.

## What This Run Job Does

The `Linear Create Issue` run job creates a new issue by:
1. Accepting issue details (title, description, team ID)
2. Making an authenticated GraphQL mutation request to Linear's API
3. Returning the created issue details including ID, identifier (e.g., "ENG-123"), and URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `linear_api_key` | Your Linear Personal API Key | `lin_api_...` |

### Getting Your Linear API Key

1. Log in to your [Linear account](https://linear.app)
2. Go to Settings (gear icon) → API
3. Click "Create Key" under "Personal API Keys"
4. Give it a name like "Xano Run Job" and copy the key

### Finding Your Team ID

1. In Linear, go to Settings → Teams
2. Select the team where you want to create issues
3. The Team ID is displayed in the URL or team settings
4. Alternatively, you can query it via the GraphQL API

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Linear Create Issue"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Linear Create Issue"
}
```

### Customizing the Issue

Edit the `input` block in `run.xs`:

```xs
run.job "Linear Create Issue" {
  main = {
    name: "create_linear_issue"
    input: {
      title: "Bug: Login button not working"
      description: "Users are reporting that the login button is unresponsive on mobile devices."
      team_id: "your-team-id-here"
    }
  }
  env = ["linear_api_key"]
}
```

## File Structure

```
linear-create-issue/
├── run.xs                         # Run job configuration
├── function/
│   └── create_issue.xs            # Function that calls Linear GraphQL API
└── README.md                      # This file
```

## Response Format

On success, the function returns:

```json
{
  "success": true,
  "issue_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "identifier": "ENG-42",
  "title": "Bug: Login button not working",
  "url": "https://linear.app/yourteam/issue/ENG-42",
  "message": "Issue created successfully in Linear"
}
```

## Error Handling

The function throws specific errors for different failure scenarios:

| Error Name | Cause |
|------------|-------|
| `inputerror` | Missing or invalid input (title, team_id) |
| `LinearAuthError` | Invalid or missing API key |
| `LinearGraphQLError` | GraphQL validation errors |
| `LinearAPIError` | Other API errors (400, non-200 responses) |

## Security Notes

- **Never commit your Linear API key** - always use environment variables
- Use a dedicated API key for this run job
- Consider creating a bot user in Linear for automated issue creation
- The API key has the same permissions as your user account

## Linear GraphQL API

Linear uses a GraphQL API. The mutation used is:

```graphql
mutation IssueCreate {
  issueCreate(input: {
    title: "Issue title"
    description: "Issue description"
    teamId: "team-id"
  }) {
    success
    issue {
      id
      identifier
      title
      url
    }
  }
}
```

## Additional Resources

- [Linear API Documentation](https://developers.linear.app/docs/graphql/working-with-the-graphql-api)
- [Linear GraphQL Explorer](https://studio.apollographql.com/public/Linear-API/variant/current/explorer)
- [XanoScript Documentation](https://docs.xano.com)

## Extending This Run Job

You can extend this run job to:
- Add labels to issues
- Assign issues to team members
- Set priority and estimate
- Add the issue to a project or cycle
- Create issues from external triggers (webhooks, scheduled tasks)

See the Linear GraphQL schema for all available fields.