// Run job to test the max_profit function
// Best Time to Buy and Sell Stock: Find max profit from one buy/sell transaction
run.job "Test Max Profit" {
  main = {
    name: "max_profit"
    input: {
      prices: [7, 1, 5, 3, 6, 4]
    }
  }
}
