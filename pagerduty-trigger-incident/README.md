# PagerDuty Trigger Incident

A Xano Run Job that triggers incidents in PagerDuty using the Events API v2.

## What This Run Job Does

This run job creates a PagerDuty incident programmatically. Use it to:

- Alert on-call teams when critical errors occur
- Trigger incidents from automated monitoring
- Integrate Xano workflows with PagerDuty incident management
- Escalate issues that require human attention

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `pagerduty_routing_key` | PagerDuty Integration Key | Services → [Your Service] → Integrations → Add Integration → Events API v2 |

## How to Use

### Basic Usage

Trigger a critical incident with minimal configuration:

```xs
run.job "PagerDuty Trigger Incident" {
  main = {
    name: "trigger_incident"
    input: {
      routing_key: $env.pagerduty_routing_key
      summary: "Database connection failed"
      severity: "critical"
    }
  }
  env = ["pagerduty_routing_key"]
}
```

### With All Options

```xs
run.job "PagerDuty Trigger Incident" {
  main = {
    name: "trigger_incident"
    input: {
      routing_key: $env.pagerduty_routing_key
      summary: "Payment processing service down"
      severity: "critical"
      source: "production-api"
      component: "payment-gateway"
      group: "billing-services"
      class: "service-outage"
      custom_details: {
        error_code: "PG_5001",
        affected_customers: 42,
        region: "us-west-2"
      }
    }
  }
  env = ["pagerduty_routing_key"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `routing_key` | text | Yes | - | Your PagerDuty Integration Key |
| `summary` | text | Yes | - | Brief description of the incident |
| `severity` | text | No | `critical` | One of: `critical`, `error`, `warning`, `info` |
| `source` | text | No | `Xano Run Job` | Source of the incident |
| `component` | text | No | - | Component affected (e.g., "database", "api") |
| `group` | text | No | - | Logical grouping (e.g., "prod-api", "staging") |
| `class` | text | No | - | Class/type of incident (e.g., "outage", "degradation") |
| `custom_details` | json | No | - | Additional key-value data for the incident |

## Severity Levels

| Level | Use Case |
|-------|----------|
| `critical` | Complete service outage, data loss, security breach |
| `error` | Degraded functionality, partial outage |
| `warning` | Potential issues, approaching thresholds |
| `info` | Informational alerts, non-urgent notifications |

## Response

The function returns:

```json
{
  "status": "incident_triggered",
  "dedup_key": "unique-dedup-key-generated",
  "incident_key": "pagerduty-dedup-key",
  "message": "Event processed",
  "status_code": 202
}
```

## File Structure

```
pagerduty-trigger-incident/
├── run.xs                    # Job configuration
├── function/
│   └── trigger_incident.xs   # Incident trigger function
└── README.md                 # This file
```

## Getting Your PagerDuty Integration Key

1. Log into PagerDuty
2. Go to **Services** → Select your service
3. Click **Integrations** tab
4. Click **Add Integration**
5. Select **Events API v2**
6. Copy the **Integration Key**
7. Set it as `pagerduty_routing_key` in your Xano environment variables

## API Reference

This job uses the [PagerDuty Events API v2](https://developer.pagerduty.com/docs/events-api-v2/overview/):

- **Endpoint**: `POST https://events.pagerduty.com/v2/enqueue`
- **Authentication**: Integration Key in request body
- **Rate Limits**: See PagerDuty documentation for current limits

## Error Handling

The function validates inputs and returns errors for:

- Missing routing_key (400 inputerror)
- Missing summary (400 inputerror)
- Invalid severity level (400 inputerror)
- PagerDuty API errors (500 standard)

## Example: Trigger from an API

```xs
query "report_error" verb=POST {
  api_group = "monitoring"
  input {
    text error_message
    text severity?=error
  }
  stack {
    function.run "trigger_incident" {
      input = {
        routing_key: $env.pagerduty_routing_key,
        summary: $input.error_message,
        severity: $input.severity,
        source: "api-error-handler"
      }
    } as $incident
  }
  response = $incident
}
```
