run.job "Zendesk Create Ticket" {
  main = {
    name: "zendesk_create_ticket"
    input: {
      subject: "Support Request from Xano Run Job"
      body: "This is a test ticket created via the Xano Run Job integration with Zendesk."
      requester_email: "test@example.com"
      requester_name: "Test User"
      priority: "normal"
      tags: ["xano", "api", "test"]
    }
  }
  env = ["zendesk_subdomain", "zendesk_email", "zendesk_api_token"]
}
