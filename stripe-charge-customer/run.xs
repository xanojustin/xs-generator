run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      amount: "2000"
      currency: "usd"
      payment_method: "pm_card_visa"
      description: "Test charge via XanoScript"
      receipt_email: "customer@example.com"
    }
  }
  env = ["STRIPE_API_KEY"]
}
