run.job "PagerDuty Trigger Incident" {
  main = {
    name: "trigger_incident"
    input: {
      summary: "Critical system alert from Xano Run Job"
      severity: "critical"
    }
  }
  env = ["pagerduty_integration_key"]
}
