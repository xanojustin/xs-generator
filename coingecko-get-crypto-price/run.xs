run.job "Fetch Crypto Price" {
  main = {
    name: "fetch_crypto_price"
    input: {
      coin_ids: "bitcoin,ethereum"
      vs_currencies: "usd,eur"
    }
  }
  env = []
}
