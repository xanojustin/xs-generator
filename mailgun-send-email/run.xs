run.job "Send Email via Mailgun" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano!"
      body: "This email was sent using the Mailgun API via Xano Run Job."
      from_name: "Xano Notifications"
    }
  }
  env = ["MAILGUN_API_KEY", "MAILGUN_DOMAIN", "MAILGUN_FROM_EMAIL"]
}
