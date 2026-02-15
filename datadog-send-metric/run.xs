run.job "Send Datadog Metric" {
  main = {
    name: "send_datadog_metric"
    input: {
      metric_name: "app.request.count"
      metric_value: 1
      metric_type: "count"
      tags: ["env:production", "service:api"]
    }
  }
  env = ["datadog_api_key", "datadog_site"]
}
