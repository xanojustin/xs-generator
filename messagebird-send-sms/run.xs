run.job "MessageBird Send SMS" {
  main = {
    name: "send_sms"
    input: {
      recipient: "+1234567890"
      message_body: "Hello from Xano via MessageBird!"
      originator: "Bird"
    }
  }
  env = ["MESSAGEBIRD_API_KEY", "MESSAGEBIRD_WORKSPACE_ID", "MESSAGEBIRD_CHANNEL_ID"]
}
