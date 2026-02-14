run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano"
      html: "<p>This email was sent using Resend API via Xano Run Job.</p>"
    }
  }
  env = ["resend_api_key"]
}
