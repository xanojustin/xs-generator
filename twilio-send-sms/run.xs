run.job "Twilio Send SMS" {
  main = {
    name: "twilio_send_sms"
    input: {
      to: "+14155551234"
      from_number: "+15005550006"
      body: "Hello from Xano! This is a test SMS sent via Twilio."
    }
  }
  env = ["twilio_account_sid", "twilio_auth_token"]
}
