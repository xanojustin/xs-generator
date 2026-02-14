run.job "Plaid Exchange Token" {
  main = {
    name: "exchange_token"
    input: {
      public_token: "public-sandbox-123456"
    }
  }
  env = ["plaid_client_id", "plaid_secret", "plaid_environment"]
}
