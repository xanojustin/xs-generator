run.job "Send Email via Postmark" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Postmark"
      body: "This is a test email sent via Postmark API."
    }
  }
  env = ["postmark_api_key", "postmark_from_email"]
}
