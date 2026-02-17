run.job "PagerDuty Create Incident" {
  main = {
    name: "create_incident"
    input: {
      title: "Server CPU High Alert"
      description: "CPU usage exceeded 90% threshold on production server"
      urgency: "high"
      service_id: "PABCDEF"
    }
  }
  env = ["pagerduty_api_key"]
}