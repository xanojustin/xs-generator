run.job "AWS SES Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "recipient@example.com"
      from_email: "sender@verified-domain.com"
      subject: "Test Email from XanoScript"
      body_text: "This is a test email sent via AWS Simple Email Service using XanoScript."
      body_html: "<html><body><h1>Test Email</h1><p>This is a test email sent via AWS Simple Email Service using XanoScript.</p></body></html>"
    }
  }
  env = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_REGION"]
}
