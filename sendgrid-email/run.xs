run.job "SendGrid Email Sender" {
  main = {
    name: "send_welcome_email"
    input: {
      to_email: "user@example.com"
      to_name: "New User"
      subject: "Welcome to our platform!"
      message: "Thank you for signing up. We're excited to have you on board!"
    }
  }
  env = ["sendgrid_api_key", "sendgrid_from_email", "sendgrid_from_name"]
}
