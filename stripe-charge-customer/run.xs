run.job "Charge Pending Invoices" {
  main = {
    name: "charge_pending_invoices"
    input: {}
  }
  env = ["STRIPE_SECRET_KEY"]
}
