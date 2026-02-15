run.job "Pusher Trigger Event" {
  main = {
    name: "trigger_event"
    input: {
      channel: "my-channel"
      event: "my-event"
      message: "Hello from XanoScript!"
    }
  }
  env = ["PUSHER_APP_ID", "PUSHER_KEY", "PUSHER_SECRET", "PUSHER_CLUSTER"]
}
