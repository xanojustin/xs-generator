run.job "Send Welcome Email" {
  main = {
    name: "send_email"
    input: {
      to_email: "hello@example.com"
      subject: "Welcome to Our Service!"
      content: "<html><body><h1>Welcome! 🎉</h1><p>Thank you for joining us. We're excited to have you on board!</p></body></html>"
      from_name: "My App Team"
      from_email: "welcome@myapp.com"
    }
  }
  env = ["SENDGRID_API_KEY"]
}
