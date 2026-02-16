run.job "Binance Get Crypto Price" {
  main = {
    name: "get_crypto_price"
    input: {
      symbol: "BTCUSDT"
    }
  }
  env = ["BINANCE_API_KEY"]
}
