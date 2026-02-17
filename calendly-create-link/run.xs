run.job "Calendly Create Scheduling Link" {
  main = {
    name: "create_scheduling_link"
    input: {
      event_type_uuid: ""
      email: ""
      name: ""
    }
  }
  env = ["calendly_api_key"]
}
