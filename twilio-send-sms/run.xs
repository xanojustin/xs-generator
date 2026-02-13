run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {
      to_phone: "+1234567890"
      message: "Hello from XanoScript!"
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token", "twilio_from_number"]
}
