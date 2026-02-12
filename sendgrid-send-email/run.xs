run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      from: "sender@example.com"
      subject: "Hello from XanoScript"
      text: "This is a test email sent via SendGrid API using XanoScript."
      html: "<p>This is a <strong>test email</strong> sent via SendGrid API using XanoScript.</p>"
    }
  }
  env = ["sendgrid_api_key"]
}
