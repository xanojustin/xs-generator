run.job "Courier Send Notification" {
  main = {
    name: "send_notification"
    input: {
      user_id: "user_123"
      template: "welcome_email"
      channel: "email"
      data: {
        first_name: "John"
        company_name: "Acme Inc"
      }
    }
  }
  env = ["COURIER_API_KEY"]
}
