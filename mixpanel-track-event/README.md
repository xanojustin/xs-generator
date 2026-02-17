# Mixpanel Track Event

This Xano Run Job tracks an event to [Mixpanel](https://mixpanel.com/), a popular product analytics platform.

## What It Does

Tracks custom events with properties to Mixpanel's analytics platform. Useful for:
- Tracking user signups, purchases, or other key actions
- Monitoring product usage and engagement
- Building analytics dashboards

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `mixpanel_api_secret` | Your Mixpanel API Secret (found in Project Settings → Service Accounts) |

## How to Use

### Default Behavior

By default, the job tracks a sample "User Signup" event:
```
event: "User Signup"
distinct_id: "user_12345"
properties: { source: "landing_page", plan: "premium" }
```

### Customizing the Event

Edit `run.xs` to change the input parameters:

```xs
run.job "Mixpanel Track Event" {
  main = {
    name: "track_event"
    input: {
      event: "Purchase Completed"
      distinct_id: "user_67890"
      properties: {
        amount: 99.99
        currency: "USD"
        product: "Pro Plan"
      }
    }
  }
  env = ["mixpanel_api_secret"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event` | text | Yes | The name of the event to track |
| `distinct_id` | text | Yes | Unique identifier for the user |
| `properties` | json | No | Additional properties to attach to the event |

## File Structure

```
mixpanel-track-event/
├── run.xs              # Run job configuration
├── function/
│   └── track_event.xs  # Function that sends event to Mixpanel
└── README.md           # This file
```

## API Reference

- [Mixpanel Import Events API](https://developer.mixpanel.com/reference/import-events)
