run.job "PayPal Create Order" {
  main = {
    name: "create_order"
    input: {
      amount: "10.00"
      currency: "USD"
      description: "Test order via XanoScript"
      return_url: "https://example.com/success"
      cancel_url: "https://example.com/cancel"
    }
  }
  env = ["PAYPAL_CLIENT_ID", "PAYPAL_CLIENT_SECRET", "PAYPAL_BASE_URL"]
}