run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1234567890"
      from_number: "+1987654321"
      message_body: "Hello from Xano Run Job! This is a test message sent via Twilio."
    }
  }
  env = ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN"]
}
