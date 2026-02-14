# Vercel Deploy Project

A XanoScript run job that triggers deployments on Vercel for your projects.

## Overview

This run job integrates with the [Vercel API](https://vercel.com/docs/rest-api) to programmatically trigger deployments for your Vercel projects. This is useful for:

- Automating deployments from Xano workflows
- Deploying projects on a schedule
- Triggering deployments after certain events
- Integrating Vercel deployments into your backend processes

## Prerequisites

1. A Vercel account with at least one project
2. A Vercel API token with appropriate permissions

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `vercel_api_token` | Yes | Your Vercel API token. Generate one at https://vercel.com/account/tokens |

## Required Permissions

Your Vercel API token needs the following permissions:
- `project:read` - To read project information
- `deployment:write` - To create deployments

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `project_id` | text | Yes | - | The ID of the Vercel project to deploy. Found in your Vercel project settings. |
| `team_id` | text | No | - | The ID of your Vercel team (if deploying a team project). Personal projects don't need this. |
| `target` | text | No | `production` | Deployment target environment. Options: `production`, `staging` |

## How to Use

### 1. Set up your environment variable

In your Xano workspace, set the `vercel_api_token` environment variable with your Vercel API token.

### 2. Run the job with inputs

You can run this job with different input parameters:

```json
{
  "project_id": "prj_xxxxxxxxxxxxxxxxxxxxxx",
  "team_id": "team_xxxxxxxxxxxxxxxxxxxxx",
  "target": "production"
}
```

### Finding Your Project ID

1. Go to your Vercel dashboard
2. Select your project
3. Go to Settings → General
4. Copy the "Project ID" value

### Finding Your Team ID (for team projects)

1. Go to your Vercel team settings
2. The team ID is shown in the URL or settings page

## Response

On success, the run job returns:

```json
{
  "success": true,
  "deployment_id": "dpl_xxxxxxxxxxxxxxxxxxxxxx",
  "url": "https://your-project-xyz123.vercel.app",
  "state": "BUILDING",
  "created_at": "2024-01-15T10:30:00.000Z",
  "project_id": "prj_xxxxxxxxxxxxxxxxxxxxxx",
  "target": "production"
}
```

## Error Handling

The run job handles common error cases:

- **401 Unauthorized**: Invalid API token
- **403 Forbidden**: Insufficient permissions
- **404 Not Found**: Project not found
- **429 Rate Limited**: Vercel API rate limit exceeded
- **Other errors**: General API errors with details

## Example: Deploying a Personal Project

```json
{
  "project_id": "prj_abc123xyz789",
  "target": "production"
}
```

## Example: Deploying a Team Project

```json
{
  "project_id": "prj_abc123xyz789",
  "team_id": "team_xyz789abc123",
  "target": "staging"
}
```

## API Reference

This run job uses the Vercel REST API:
- Endpoint: `POST https://api.vercel.com/v13/deployments`
- Documentation: https://vercel.com/docs/rest-api/endpoints/deployments#create-a-new-deployment

## File Structure

```
vercel-deploy-project/
├── run.xs                           # Run job definition
├── function/
│   └── trigger_vercel_deployment.xs # Main function logic
└── README.md                        # This file
```

## Notes

- Deployments are asynchronous. The job returns immediately with the deployment ID, but the actual build and deployment process happens in the background on Vercel.
- Check your Vercel dashboard to monitor deployment progress.
- The deployment `state` in the response will typically be `BUILDING` or `QUEUED` immediately after creation.
