run.job "Twilio Verify Phone" {
  main = {
    name: "start_verification"
    input: {
      to_phone: "+1234567890"
      channel: "sms"
      service_sid: "VAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token"]
}