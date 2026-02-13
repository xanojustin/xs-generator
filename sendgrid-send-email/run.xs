run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano!"
      html: "<p>This is a test email sent via the SendGrid API using XanoScript.</p>"
    }
  }
  env = ["sendgrid_api_key", "sendgrid_from_email"]
}
