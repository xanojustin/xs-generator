run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano"
      body: "<p>This email was sent via Resend API using Xano Run Job.</p>"
      from: "onboarding@resend.dev"
    }
  }
  env = ["RESEND_API_KEY"]
}
