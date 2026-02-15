# Datadog Send Metric

A Xano Run Job that sends custom metrics to Datadog for monitoring and observability.

## What It Does

This run job sends custom metrics to Datadog's Metrics API. You can use it to track:
- Application performance metrics
- Business KPIs
- Custom events and counters
- Infrastructure monitoring data

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `datadog_api_key` | Your Datadog API key | `abc123...` |
| `datadog_site` | Datadog site (optional, defaults to `datadoghq.com`) | `datadoghq.eu` |

## Usage

### Default Run

Executes with default metric values:
- Metric name: `app.request.count`
- Value: `1`
- Type: `count`
- Tags: `env:production`, `service:api`

### Custom Input Parameters

When running the job, you can override these inputs:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `metric_name` | text | `app.request.count` | Name of the metric |
| `metric_value` | decimal | `1` | Value to record |
| `metric_type` | text | `gauge` | Metric type: `gauge`, `count`, `rate`, `set` |
| `tags` | text[] | `["env:production", "service:api"]` | Array of tag strings |

## Metric Types

- **gauge**: Point-in-time value (e.g., current memory usage)
- **count**: Cumulative counter (e.g., total requests)
- **rate**: Value per second (e.g., requests per second)
- **set**: Count of unique elements (e.g., unique users)

## Example Response

```json
{
  "success": true,
  "metric": "app.request.count",
  "value": 1,
  "status": 202
}
```

## Files

- `run.xs` - Run job configuration
- `function/send_metric.xs` - Function that sends the metric to Datadog
