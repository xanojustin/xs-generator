run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano via SendGrid"
      body: "<p>This email was sent via SendGrid API using Xano Run Job.</p>"
      from: "sender@example.com"
    }
  }
  env = ["SENDGRID_API_KEY"]
}
