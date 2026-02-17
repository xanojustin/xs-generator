# Datadog Submit Metric - Xano Run Job

This Xano run job submits custom metrics to Datadog's monitoring platform.

## What It Does

Submits custom metrics (gauge, count, or rate) to Datadog for monitoring and observability. Useful for:

- Tracking application performance metrics
- Monitoring business KPIs
- Sending custom events as metrics
- Integration with Datadog dashboards and alerts

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `DATADOG_API_KEY` | Your Datadog API key | [Datadog API Keys](https://app.datadoghq.com/organization-settings/api-keys) |
| `DATADOG_APP_KEY` | Your Datadog Application key | [Datadog Application Keys](https://app.datadoghq.com/organization-settings/application-keys) |

## Files

```
datadog-submit-metric/
├── run.xs              # Job configuration
├── function/
│   └── submit_metric.xs  # Metric submission logic
└── README.md           # This file
```

## Usage

### Basic Usage

The job is pre-configured with example values. Customize in `run.xs`:

```xs
run.job "Datadog Submit Custom Metric" {
  main = {
    name: "submit_metric"
    input: {
      metric_name: "your.metric.name"
      value: 42.0
      type: "gauge"
      tags: ["env:production", "team:engineering"]
    }
  }
}
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `metric_name` | text | Yes | - | Full metric name (e.g., `custom.app.requests`) |
| `value` | decimal | Yes | - | Numeric value to submit |
| `type` | text | No | "gauge" | Metric type: `gauge`, `count`, or `rate` |
| `tags` | text[] | No | [] | Array of tag strings (e.g., `["env:prod", "region:us"]` ) |
| `host` | text | No | "" | Host name for the metric |

### Metric Types

- **gauge**: Instant value (current temperature, queue depth)
- **count**: Cumulative count (requests processed, errors occurred)
- **rate**: Rate per second (requests/second, bytes/second)

## Example: Track Daily Active Users

```xs
run.job "Track DAU" {
  main = {
    name: "submit_metric"
    input: {
      metric_name: "custom.business.daily_active_users"
      value: 1523.0
      type: "gauge"
      tags: ["product:mobile", "version:2.1.0"]
    }
  }
}
```

## Example: Track API Request Count

```xs
run.job "Track API Requests" {
  main = {
    name: "submit_metric"
    input: {
      metric_name: "custom.api.requests"
      value: 1000.0
      type: "count"
      tags: ["endpoint:/users", "method:GET", "status:200"]
    }
  }
}
```

## Error Handling

The function handles common Datadog API errors:

- **400 Bad Request**: Invalid metric format
- **403 Forbidden**: Invalid API/App key
- **429 Rate Limit**: Too many requests (retry later)

## Datadog Dashboard

Once metrics are submitted, you can:

1. View in [Datadog Metrics Explorer](https://app.datadoghq.com/metric/explorer)
2. Create dashboards with custom widgets
3. Set up monitors and alerts
4. Use in SLOs (Service Level Objectives)

## API Reference

- [Datadog Metrics API Docs](https://docs.datadoghq.com/api/latest/metrics/)
- [Datadog Posting Metrics](https://docs.datadoghq.com/metrics/custom_metrics/)

## Notes

- Metric names should follow Datadog naming conventions (lowercase, dots as separators)
- Tags help filter and group metrics in Datadog
- Datadog has [custom metrics pricing](https://docs.datadoghq.com/account_management/billing/custom_metrics/)
