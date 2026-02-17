run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      customer_id: "cus_example123"
      amount: 50.00
      currency: "usd"
      description: "Test charge via Xano Run Job"
    }
  }
  env = ["STRIPE_SECRET_KEY"]
}
