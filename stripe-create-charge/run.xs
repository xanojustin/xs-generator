run.job "Stripe Create Customer and Charge" {
  main = {
    name: "stripe_create_charge"
    input: {
      customer_email: "customer@example.com"
      customer_name: "John Doe"
      amount: 49.99
      currency: "usd"
      description: "Premium Plan Subscription"
      payment_method: "pm_card_visa"
    }
  }
  env = ["stripe_secret_key"]
}
