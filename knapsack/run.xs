// Run job to test the knapsack function
run.job "Test Knapsack" {
  main = {
    name: "knapsack"
    input: {
      weights: [2, 3, 4, 5]
      values: [3, 4, 5, 6]
      capacity: 5
    }
  }
}
