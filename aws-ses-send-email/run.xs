run.job "AWS SES Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "recipient@example.com"
      to_name: "Recipient Name"
      subject: "Test Email from Xano"
      body_text: "This is a test email sent via AWS SES."
      body_html: "<h1>Test Email</h1><p>This is a test email sent via AWS SES.</p>"
      from_email: "sender@example.com"
      from_name: "Sender Name"
      reply_to: "reply@example.com"
    }
  }
  env = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_REGION"]
}
