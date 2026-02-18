run.job "Stripe Create Subscription" {
  main = {
    name: "create_subscription"
    input: {
      customer_email: "customer@example.com"
      price_id: "price_1234567890"
    }
  }
  env = ["STRIPE_API_KEY"]
}
