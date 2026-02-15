run.job "Freshdesk Create Ticket" {
  main = {
    name: "create_ticket"
    input: {
      subject: "Support Request from XanoScript"
      description: "This ticket was created via the Freshdesk API using XanoScript."
      email: "customer@example.com"
      priority: 1
      status: 2
    }
  }
  env = ["FRESHDESK_API_KEY", "FRESHDESK_DOMAIN"]
}
