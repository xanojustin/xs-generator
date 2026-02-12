run.job "Stripe Payment Monitor" {
  main = {
    name: "fetch_recent_charges"
    input: {
      limit: 10
      status: "succeeded"
    }
  }
  env = ["stripe_secret_key"]
}