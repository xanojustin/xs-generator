run.job "Intercom Send Message" {
  main = {
    name: "send_message"
    input: {
      message_body: "Hello! This is a test message from Xano Run Job."
      message_type: "email"
      to_email: "test@example.com"
      subject: "Test Message from Xano"
    }
  }
  env = ["INTERCOM_API_KEY"]
}
