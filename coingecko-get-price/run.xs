run.job "Get Crypto Price" {
  main = {
    name: "get_crypto_price"
    input: {
      coin_id: "bitcoin"
      currency: "usd"
    }
  }
}
