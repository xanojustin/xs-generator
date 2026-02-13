run.job "Send Twilio SMS" {
  main = {
    name: "send_sms"
    input: {}
  }
  env = ["twilio_account_sid", "twilio_auth_token", "twilio_from_number", "twilio_to_number", "twilio_message_body"]
}
