run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "recipient@example.com"
      to_name: "Recipient Name"
      from_email: "sender@example.com"
      from_name: "Sender Name"
      subject: "Hello from XanoScript!"
      body_text: "This is a test email sent via SendGrid using XanoScript."
      body_html: "<h1>Hello!</h1><p>This is a test email sent via <strong>SendGrid</strong> using XanoScript.</p>"
    }
  }
  env = ["SENDGRID_API_KEY"]
}