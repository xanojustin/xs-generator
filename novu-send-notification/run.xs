run.job "Novu Send Notification" {
  main = {
    name: "send_novu_notification"
    input: {
      subscriber_id: "user_123"
      workflow_id: "welcome-email"
      payload: {}
    }
  }
  env = ["NOVU_API_KEY"]
}
