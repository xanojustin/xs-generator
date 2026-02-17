run.job "Mixpanel Track Event" {
  main = {
    name: "track_event"
    input: {
      event: "User Signup"
      distinct_id: "user_12345"
      properties: {
        source: "landing_page"
        plan: "premium"
      }
    }
  }
  env = ["mixpanel_api_secret"]
}
