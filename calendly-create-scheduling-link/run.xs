run.job "Calendly Create Scheduling Link" {
  main = {
    name: "calendly_create_scheduling_link"
    input: {
      event_type_uri: "https://api.calendly.com/event_types/ABC123XYZ"
      max_event_count: 1
    }
  }
  env = ["calendly_api_token"]
}
