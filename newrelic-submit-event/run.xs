run.job "New Relic Submit Event" {
  main = {
    name: "submit_event"
    input: {
      event_type: "CustomEvent"
      account_id: "1234567"
      event_data: {
        appName: "MyApplication"
        environment: "production"
        userId: "user_12345"
        action: "purchase"
        value: 99.99
      }
    }
  }
  env = ["NEW_RELIC_INSERT_KEY"]
}
