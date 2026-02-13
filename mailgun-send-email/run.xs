run.job "Mailgun Send Email" {
  main = {
    name: "mailgun_send_email"
    input: {
      to: "recipient@example.com"
      from: "sender@yourdomain.com"
      subject: "Hello from Xano!"
      text: "This is a test email sent via Mailgun."
      html: "<h1>Hello!</h1><p>This is a test email sent via <b>Mailgun</b>.</p>"
    }
  }
  env = ["mailgun_api_key", "mailgun_domain"]
}