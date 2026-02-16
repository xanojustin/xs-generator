# LaunchDarkly Toggle Feature Flag

A Xano Run Job that toggles feature flags in LaunchDarkly. This job enables or disables feature flags in specific environments, making it easy to automate feature rollouts and rollbacks.

## What This Run Job Does

This run job updates a feature flag's enabled state in LaunchDarkly. It's useful for:

- **Automated feature rollouts** - Enable features after passing CI/CD checks
- **Emergency rollbacks** - Quickly disable problematic features
- **Scheduled releases** - Enable features at specific times
- **Environment synchronization** - Keep feature states consistent across environments

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `launchdarkly_api_key` | Your LaunchDarkly API key | LaunchDarkly Dashboard → Account settings → Authorization |
| `launchdarkly_project_key` | Your LaunchDarkly project key | LaunchDarkly Dashboard → Project settings |

## How to Use

### Basic Usage

Toggle a feature flag on:

```xs
run.job "LaunchDarkly Toggle Feature Flag" {
  main = {
    name: "toggle_feature_flag"
    input: {
      flag_key: "new-dashboard-feature"
      environment_key: "production"
      enabled: true
    }
  }
  env = ["launchdarkly_api_key", "launchdarkly_project_key"]
}
```

Toggle a feature flag off:

```xs
run.job "LaunchDarkly Toggle Feature Flag" {
  main = {
    name: "toggle_feature_flag"
    input: {
      flag_key: "new-dashboard-feature"
      environment_key: "production"
      enabled: false
    }
  }
  env = ["launchdarkly_api_key", "launchdarkly_project_key"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `flag_key` | text | Yes | The unique key of the feature flag to toggle |
| `environment_key` | text | Yes | The environment key (e.g., "production", "staging", "development") |
| `enabled` | boolean | Yes | Whether to enable (`true`) or disable (`false`) the flag |

### Response

On success, the job returns:

```json
{
  "success": true,
  "flag_key": "new-dashboard-feature",
  "environment": "production",
  "enabled": true,
  "name": "New Dashboard Feature",
  "description": "Enables the new dashboard UI",
  "maintainer": "team@example.com"
}
```

### Error Handling

The job handles the following error cases:

- **401 Unauthorized** - Invalid API key
- **404 Not Found** - Feature flag or project not found
- **Other API errors** - Returns detailed error message with status code

## Files

```
launchdarkly-toggle-flag/
├── run.xs                          # Run job configuration
├── function/
│   └── toggle_feature_flag.xs     # Main function implementation
└── README.md                       # This file
```

## LaunchDarkly API Reference

This job uses the LaunchDarkly REST API:

- **Endpoint**: `PATCH /api/v2/flags/{projectKey}/{featureFlagKey}`
- **Documentation**: https://apidocs.launchdarkly.com/

## Security Notes

- Store your `launchdarkly_api_key` as an environment variable, never hardcode it
- Use a LaunchDarkly API key with minimal required permissions (only `writer` role needed)
- Consider using separate API keys for different environments
