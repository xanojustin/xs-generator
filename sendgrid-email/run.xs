run.job "SendGrid Send Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "recipient@example.com"
      to_name: "Recipient Name"
      from_email: "sender@yourdomain.com"
      from_name: "Your App Name"
      subject: "Test Email from Xano"
      body_text: "This is a test email sent via SendGrid from a Xano Run Job."
      body_html: "<p>This is a <strong>test email</strong> sent via SendGrid from a Xano Run Job.</p>"
    }
  }
  env = ["sendgrid_api_key"]
}
