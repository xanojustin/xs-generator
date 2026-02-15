run.job "Mixpanel Track Event" {
  main = {
    name: "track_event"
    input: {
      event: "User Action"
      distinct_id: "user_12345"
      properties: "{\"action\": \"button_click\", \"page\": \"homepage\", \"plan\": \"pro\"}"
      ip: "192.168.1.1"
    }
  }
  env = ["MIXPANEL_PROJECT_TOKEN"]
}
