run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      amount: 2000
      currency: "usd"
      description: "Test charge from Xano Run Job"
      customer_email: "customer@example.com"
    }
  }
  env = ["stripe_secret_key"]
}
