run.job "Twilio SMS Sender" {
  main = {
    name: "send_sms"
    input: {
      to: "+1234567890"
      message: "Hello from Xano! This is a test message sent via Twilio."
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token", "twilio_phone_number"]
}
