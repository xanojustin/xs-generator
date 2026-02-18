run.job "QuickBooks Create Invoice" {
  main = {
    name: "create_invoice"
    input: {
      customer_id: "1"
      customer_name: "Acme Corporation"
      customer_email: "billing@acme.com"
      item_names: ["Consulting Services", "Software License"]
      item_amounts: [500.00, 299.99]
      item_descriptions: ["Monthly consulting retainer", "Annual software license"]
      item_quantities: [1, 1]
      invoice_date: ""
      due_date: ""
      memo: "Thank you for your business!"
    }
  }
  env = ["QUICKBOOKS_ACCESS_TOKEN", "QUICKBOOKS_REALM_ID"]
}
