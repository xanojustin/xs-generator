run.job "Square Create Payment" {
  main = {
    name: "create_payment"
    input: {
      source_id: "cnon:card-nonce-ok"
      amount: 50.00
      currency: "USD"
      note: "Test payment via Xano Run Job"
      reference_id: "order-12345"
    }
  }
  env = ["SQUARE_ACCESS_TOKEN", "SQUARE_ENVIRONMENT"]
}
