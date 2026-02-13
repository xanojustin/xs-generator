run.job "Plaid Get Account Balances" {
  main = {
    name: "plaid_get_balance"
    input: {
      access_token: "access-sandbox-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      plaid_environment: "sandbox"
    }
  }
  env = ["plaid_client_id", "plaid_secret"]
}
