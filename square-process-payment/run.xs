run.job "Process Square Payment" {
  main = {
    name: "process_square_payment"
    input: {
      amount: 1000
      currency: "USD"
      source_id: "cnon:card-nonce-ok"
      idempotency_key: ""
      note: "Test payment via Xano Run Job"
    }
  }
  env = ["SQUARE_ACCESS_TOKEN", "SQUARE_ENVIRONMENT"]
}