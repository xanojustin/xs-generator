run.job "Stripe Create Charge" {
  main = {
    name: "stripe_charge"
    input: {
      amount: 2000
      currency: "usd"
      source: "tok_visa"
      description: "Test charge from Xano Run Job"
    }
  }
  env = ["stripe_secret_key"]
}
