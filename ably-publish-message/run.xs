run.job "Ably Publish Message" {
  main = {
    name: "publish_message"
    input: {
      channel: "notifications"
      event_name: "user.notification"
      data: {
        title: "Hello from Xano!"
        body: "This message was published via Xano Run Job"
        timestamp: "2026-02-15T11:15:00Z"
      }
    }
  }
  env = ["ABLY_API_KEY"]
}
