run.job "Fixer Exchange Rate Fetcher" {
  main = {
    name: "fetch_exchange_rates"
    input: {
      base_currency: "USD"
      target_currencies: ["EUR", "GBP", "JPY", "CAD", "AUD"]
    }
  }
  env = ["FIXER_API_KEY"]
}
