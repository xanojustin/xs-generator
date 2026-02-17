run.job "Pusher Trigger Event" {
  main = {
    name: "trigger_event"
    input: {
      channel: "my-channel"
      event_name: "my-event"
      data: { message: "Hello from Xano!", timestamp: "2025-02-17T13:45:00Z" }
    }
  }
  env = ["PUSHER_APP_ID", "PUSHER_KEY", "PUSHER_SECRET"]
}
