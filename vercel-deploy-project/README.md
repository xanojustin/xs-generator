# Vercel Deploy Project

A Xano Run Job that triggers deployments for Vercel projects and monitors their status until complete.

## What It Does

This run job:
1. Triggers a new deployment for a specified Vercel project
2. Polls the deployment status until it completes (READY, ERROR, or CANCELED)
3. Returns the deployment URL and final status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `vercel_api_token` | Your Vercel API token (create at https://vercel.com/account/tokens) |

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `project_id` | text | Yes | - | The Vercel project ID to deploy |
| `team_id` | text | No | "" | Optional team/slug ID for team-owned projects |
| `target` | text | No | "production" | Deployment target: "production" or "preview" |

## How to Use

### Basic Usage (Production Deployment)

```json
{
  "project_id": "prj_xxxxxxxxxxxx"
}
```

### Preview Deployment for Team Project

```json
{
  "project_id": "prj_xxxxxxxxxxxx",
  "team_id": "my-team-slug",
  "target": "preview"
}
```

## Response

```json
{
  "success": true,
  "deployment_id": "dpl_xxxxxxxxxxxx",
  "url": "https://my-app.vercel.app",
  "state": "READY",
  "project_id": "prj_xxxxxxxxxxxx",
  "target": "production",
  "polled_attempts": 5
}
```

## Vercel API Reference

- [Create Deployment](https://vercel.com/docs/rest-api/endpoints/deployments#create-a-new-deployment)
- [Get Deployment](https://vercel.com/docs/rest-api/endpoints/deployments#get-a-deployment-by-id-or-url)

## Finding Your Project ID

1. Go to your Vercel dashboard
2. Select your project
3. The project ID is in Settings → General → Project ID

Or use the Vercel CLI:
```bash
vercel projects list
```
