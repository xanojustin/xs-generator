run.job "Mailjet Send Email" {
  main = {
    name: "mailjet_send_email"
    input: {
      from_email: "sender@example.com"
      from_name: "Your Name"
      to_email: "recipient@example.com"
      to_name: "Recipient Name"
      subject: "Test Email from Xano Run Job"
      text_content: "This is a test email sent via Mailjet from a Xano Run Job."
      html_content: "<h1>Test Email</h1><p>This is a test email sent via <strong>Mailjet</strong> from a Xano Run Job.</p>"
    }
  }
  env = ["mailjet_api_key", "mailjet_secret_key"]
}
