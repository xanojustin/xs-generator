run.job "PagerDuty Trigger Incident" {
  main = {
    name: "trigger_incident"
    input: {}
  }
  env = ["pagerduty_routing_key"]
}
