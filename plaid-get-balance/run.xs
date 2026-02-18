run.job "Plaid Get Account Balance" {
  main = {
    name: "exchange_and_get_balance"
    input: {
      public_token: ""
    }
  }
  env = ["PLAID_CLIENT_ID", "PLAID_SECRET", "PLAID_ENV"]
}
