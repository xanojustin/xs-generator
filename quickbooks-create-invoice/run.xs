run.job "QuickBooks Create Invoice" {
  main = {
    name: "create_invoice"
    input: {
      customer_name: "Acme Corp"
      customer_email: "billing@acmecorp.com"
      line_items: [
        {
          description: "Consulting Services"
          amount: 500.00
          quantity: 2
        },
        {
          description: "Software License"
          amount: 299.99
          quantity: 1
        }
      ]
      due_date: "2026-03-15"
    }
  }
  env = ["quickbooks_access_token", "quickbooks_realm_id", "quickbooks_environment"]
}
