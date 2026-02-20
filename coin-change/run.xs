// Run job to test the coin change function
run.job "Test Coin Change" {
  main = {
    name: "coin_change"
    input: {
      coins: [1, 2, 5]
      amount: 11
    }
  }
}
