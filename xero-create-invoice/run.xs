run.job "Xero Create Invoice" {
  main = {
    name: "create_xero_invoice"
    input: {
      tenant_id: ""
      contact_name: ""
      contact_email: ""
      description: ""
      quantity: 1
      unit_amount: 0.00
      account_code: "200"
      invoice_type: "ACCREC"
      invoice_status: "DRAFT"
      date: ""
      due_date: ""
    }
  }
  env = ["XERO_ACCESS_TOKEN"]
}