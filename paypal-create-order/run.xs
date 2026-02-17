run.job "PayPal Create Order" {
  main = {
    name: "paypal_order"
    input: {
      intent: "CAPTURE"
      purchase_units: [
        {
          amount: {
            currency_code: "USD"
            value: "50.00"
          }
          description: "Order from Xano Run Job"
        }
      ]
    }
  }
  env = ["paypal_client_id", "paypal_client_secret"]
}
