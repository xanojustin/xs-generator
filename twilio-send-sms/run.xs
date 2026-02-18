run.job "Twilio Send SMS" {
  main = {
    name: "send_sms"
    input: {
      to_number: "+1234567890"
      message_body: "Hello from Xano!"
      from_number: ""
    }
  }
  env = ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN", "TWILIO_PHONE_NUMBER"]
}
