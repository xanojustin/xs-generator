run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1234567890"
      message: "Hello from Xano!"
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token", "twilio_phone_number"]
}
