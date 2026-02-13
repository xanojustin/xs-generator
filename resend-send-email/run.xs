run.job "Resend Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano!"
      html: "<p>This email was sent using the Resend API via XanoScript.</p>"
    }
  }
  env = ["RESEND_API_KEY"]
}
