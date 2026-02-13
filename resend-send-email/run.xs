run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano!"
      html: "<p>This is a test email sent via the Resend API using XanoScript.</p>"
    }
  }
  env = ["resend_api_key", "resend_from_email"]
}