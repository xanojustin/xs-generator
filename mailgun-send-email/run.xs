run.job "Mailgun Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano"
      body: "<p>This email was sent via Mailgun API using Xano Run Job.</p>"
      from: "sender@your-domain.com"
    }
  }
  env = ["MAILGUN_API_KEY"]
}
