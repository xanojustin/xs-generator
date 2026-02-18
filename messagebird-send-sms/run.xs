run.job "MessageBird Send SMS" {
  main = {
    name: "messagebird_send_sms"
    input: {
      recipient: "+1234567890"
      originator: "XanoSMS"
      message: "Hello from Xano Run Job!"
    }
  }
  env = ["messagebird_api_key"]
}
