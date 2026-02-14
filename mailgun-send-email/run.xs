run.job "Mailgun Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      from: "sender@yourdomain.com"
      subject: "Test email from Xano Run Job"
      text_body: "This is a test email sent via Mailgun using XanoScript."
    }
  }
  env = ["MAILGUN_API_KEY", "MAILGUN_DOMAIN"]
}
