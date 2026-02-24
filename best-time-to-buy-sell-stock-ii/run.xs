// Run job to test the max_profit_ii function
run.job "Test Max Profit II" {
  main = {
    name: "max_profit_ii"
    input: {
      prices: [7, 1, 5, 3, 6, 4]
    }
  }
}
