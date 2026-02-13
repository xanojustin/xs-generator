run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {}
  }
  env = ["stripe_secret_key", "stripe_amount", "stripe_currency", "stripe_customer_id", "stripe_payment_method_id"]
}
