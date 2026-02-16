# CircleCI Trigger Pipeline Run Job

This Xano run job triggers a CircleCI pipeline for a specified project and branch.

## What It Does

The run job makes an authenticated POST request to the CircleCI API v2 to trigger a new pipeline run. This is useful for:

- Automating CI/CD workflows from Xano
- Triggering deployments programmatically
- Integrating CircleCI with your backend processes
- Scheduling pipeline runs via Xano tasks

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `circleci_api_token` | Your CircleCI Personal API Token (from CircleCI Dashboard → Personal API Tokens) |

## How to Use

### Basic Usage

Trigger a pipeline on the main branch:

```xs
run.job "Trigger CircleCI Pipeline" {
  main = {
    name: "trigger_pipeline"
    input: {
      project_slug: "gh/myorg/myrepo"
      branch: "main"
    }
  }
  env = ["circleci_api_token"]
}
```

### With Pipeline Parameters

Trigger with custom parameters (defined in your `.circleci/config.yml`):

```xs
run.job "Trigger with Parameters" {
  main = {
    name: "trigger_pipeline"
    input: {
      project_slug: "gh/myorg/myrepo"
      branch: "feature-branch"
      parameters: {
        deploy_environment: "staging"
        run_tests: true
      }
    }
  }
  env = ["circleci_api_token"]
}
```

## Project Slug Format

The `project_slug` follows the format: `{provider}/{org}/{repo}`

- **GitHub**: `gh/myorg/myrepo`
- **Bitbucket**: `bb/myorg/myrepo`

## Response

On success, the function returns:

```json
{
  "success": true,
  "pipeline_id": "uuid-string",
  "pipeline_number": 123,
  "state": "pending",
  "created_at": "2024-01-15T10:30:00.000Z",
  "project_slug": "gh/myorg/myrepo",
  "branch": "main"
}
```

## CircleCI API Reference

- [Trigger New Pipeline](https://circleci.com/docs/api/v2/index.html#operation/triggerPipeline)
- [Pipeline Parameters](https://circleci.com/docs/pipeline-variables/#pipeline-parameters-in-configuration)

## Setup Instructions

1. Get your API token from [CircleCI Dashboard](https://app.circleci.com/settings/user/tokens)
2. Set `circleci_api_token` in your Xano environment variables
3. Update the `project_slug` in the run job input to match your repository
4. Run the job via Xano Job Runner
