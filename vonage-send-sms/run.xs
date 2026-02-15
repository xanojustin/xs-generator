run.job "Vonage Send SMS" {
  main = {
    name: "send_sms"
    input: {
      to: "+1234567890"
      message: "Hello from Xano Run Job!"
    }
  }
  env = ["vonage_api_key", "vonage_api_secret", "vonage_from_number"]
}
