# Zapier Trigger Zap - Run Job

This Xano Run Job triggers a Zapier Zap via webhook URL.

## What It Does

This run job sends a POST request to a Zapier webhook URL, triggering a Zap (automation workflow) in Zapier. It's useful for:

- Initiating Zapier workflows from Xano
- Sending data to Zapier for processing
- Integrating with 5000+ apps via Zapier
- Triggering multi-step automations

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `ZAPIER_WEBHOOK_URL` | Your Zapier webhook URL | Yes |

## How to Use

### 1. Set up your Zap in Zapier

1. Go to [Zapier](https://zapier.com) and create a new Zap
2. Choose "Webhooks by Zapier" as the trigger
3. Select "Catch Hook" as the trigger event
4. Copy the webhook URL provided by Zapier

### 2. Configure the Run Job

Update the `run.xs` file with your webhook URL:

```xs
run.job "Trigger Zapier Zap" {
  main = {
    name: "trigger_zap"
    input: {
      webhook_url: "https://hooks.zapier.com/hooks/catch/123456/abcdef"
      data: {
        event: "user_signup"
        user_id: 123
        email: "user@example.com"
      }
    }
  }
  env = ["ZAPIER_WEBHOOK_URL"]
}
```

Or use the environment variable:

```xs
run.job "Trigger Zapier Zap" {
  main = {
    name: "trigger_zap"
    input: {
      webhook_url: $env.ZAPIER_WEBHOOK_URL
      data: {}
    }
  }
  env = ["ZAPIER_WEBHOOK_URL"]
}
```

### 3. Run the Job

Execute via Xano CLI or the Xano dashboard.

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `webhook_url` | text | Yes | The Zapier webhook URL to trigger |
| `data` | json | No | JSON payload to send to Zapier |

## Response

```json
{
  "success": true,
  "status": 200,
  "message": "Zap triggered successfully"
}
```

## File Structure

```
zapier-trigger-zap/
├── run.xs                 # Run job configuration
├── function/
│   └── trigger_zap.xs     # Function that triggers the webhook
└── README.md              # This file
```

## Example Use Cases

### Send new user data to Zapier

```xs
input {
  webhook_url: "https://hooks.zapier.com/hooks/catch/123456/abcdef"
  data: {
    event: "user_created"
    user_id: 123
    email: "user@example.com"
    name: "John Doe"
  }
}
```

### Trigger CRM update

```xs
input {
  webhook_url: "https://hooks.zapier.com/hooks/catch/123456/abcdef"
  data: {
    event: "lead_qualified"
    lead_id: 456
    score: 85
    source: "website"
  }
}
```

## Notes

- Zapier webhooks respond immediately but the actual Zap execution happens asynchronously
- The webhook URL is unique to each Zap
- You can pass any JSON data in the `data` parameter
- Metadata (`_triggered_at`, `_source`) is automatically added to each request
