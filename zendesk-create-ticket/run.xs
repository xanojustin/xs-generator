run.job "Zendesk Create Ticket" {
  main = {
    name: "create_ticket"
    input: {
      subject: "Support Request from XanoScript"
      body: "This is a test ticket created via XanoScript run job."
      priority: "normal"
      requester_name: "Test User"
      requester_email: "test@example.com"
      tags: "xano,api,test"
    }
  }
  env = ["ZENDESK_SUBDOMAIN", "ZENDESK_API_TOKEN", "ZENDESK_API_EMAIL"]
}
