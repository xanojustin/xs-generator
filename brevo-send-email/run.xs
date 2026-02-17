run.job "Brevo Send Transactional Email" {
  main = {
    name: "send_transactional_email"
    input: {
      to_email: "recipient@example.com"
      to_name: "Recipient Name"
      subject: "Welcome to Our Service"
      html_content: "<h1>Welcome!</h1><p>Thanks for joining us.</p>"
      text_content: "Welcome! Thanks for joining us."
      sender_email: "sender@example.com"
      sender_name: "Your Company"
    }
  }
  env = ["BREVO_API_KEY"]
}
