run.job "Postmark Send Email" {
  main = {
    name: "send_email"
    input: {
      to: "recipient@example.com"
      subject: "Hello from Xano via Postmark"
      html_body: "<p>This email was sent using Postmark API via Xano Run Job.</p>"
    }
  }
  env = ["postmark_server_token"]
}
