run.job "Brevo Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "recipient@example.com"
      to_name: "Test Recipient"
      from_email: "sender@yourdomain.com"
      from_name: "Your App Name"
      subject: "Test Email from XanoScript"
      html_content: "<h1>Hello!</h1><p>This is a test email sent via Brevo API using XanoScript.</p>"
      text_content: "Hello! This is a test email sent via Brevo API using XanoScript."
    }
  }
  env = ["BREVO_API_KEY"]
}
