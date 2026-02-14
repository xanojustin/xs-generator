run.job "Alchemy Get ETH Balance" {
  main = {
    name: "fetch_eth_balance"
    input: {
      wallet_address: "0x742d35Cc6634C0532925a3b844Bc9e7595f7cB8E"
    }
  }
  env = ["ALCHEMY_API_KEY"]
}
