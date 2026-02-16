run.job "Send Email via Microsoft Graph" {
  main = {
    name: "send_outlook_email"
    input: {
      to_address: "recipient@example.com"
      subject: "Hello from Xano"
      body: "This email was sent using the Microsoft Graph API and XanoScript."
      body_content_type: "HTML"
    }
  }
  env = ["MS_GRAPH_CLIENT_ID", "MS_GRAPH_CLIENT_SECRET", "MS_GRAPH_TENANT_ID", "MS_GRAPH_FROM_EMAIL"]
}