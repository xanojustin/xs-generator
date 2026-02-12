run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano"
      body: "This email was sent via SendGrid using XanoScript!"
    }
  }
  env = ["SENDGRID_API_KEY", "SENDGRID_FROM_EMAIL"]
}