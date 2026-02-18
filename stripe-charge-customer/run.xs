run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      amount: 2000
      currency: "usd"
      customer_email: "customer@example.com"
      description: "Payment for services"
    }
  }
  env = ["STRIPE_API_KEY"]
}
