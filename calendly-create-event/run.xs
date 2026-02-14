run.job "Calendly Create One-Off Event" {
  main = {
    name: "create_one_off_event_type"
    input: {
      name: "Product Demo Meeting"
      duration: 30
      timezone: "America/Los_Angeles"
      location_type: "zoom"
    }
  }
  env = ["CALENDLY_API_KEY"]
}
