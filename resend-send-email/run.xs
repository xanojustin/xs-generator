run.job "Send Email via Resend" {
  main = {
    name: "send_email"
    input: {
      to_email: "hello@example.com"
      subject: "Welcome to Resend Email Service!"
      content: "<html><body><h1>Welcome! 🚀</h1><p>This email was sent using the <strong>Resend API</strong> via Xano Run Jobs.</p><p>Resend provides a simple, developer-friendly API for transactional emails.</p><hr/><p><small>Sent with ❤️ from Xano</small></p></body></html>"
      from_name: "Xano App"
      from_email: "onboarding@resend.dev"
    }
  }
  env = ["RESEND_API_KEY"]
}
