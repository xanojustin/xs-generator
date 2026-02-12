run.job "Stripe Create Payment Intent" {
  main = {
    name: "create_payment_intent"
    input: {
      amount: 5000
      currency: "usd"
      description: "Test payment via Xano run job"
    }
  }
  env = ["stripe_secret_key"]
}
