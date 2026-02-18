run.job "PagerDuty Create Incident" {
  main = {
    name: "create_pagerduty_incident"
    input: {
      title: "Server outage in production"
      service_key: "your-service-integration-key"
      urgency: "high"
      body: "The production API is returning 500 errors."
    }
  }
  env = ["PAGERDUTY_API_KEY"]
}
