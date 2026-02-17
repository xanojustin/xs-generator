run.job "Datadog Submit Custom Metric" {
  main = {
    name: "submit_metric"
    input: {
      metric_name: "custom.application.active_users"
      value: 1.0
      type: "gauge"
      tags: ["env:production", "service:xano-runner"]
    }
  }
  env = ["DATADOG_API_KEY", "DATADOG_APP_KEY"]
}
