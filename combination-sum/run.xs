// Run job to test the combination_sum function
// Combination Sum: Find all unique combinations that sum to target
// Same number can be used unlimited times
run.job "Test Combination Sum" {
  main = {
    name: "combination_sum"
    input: {
      candidates: [2, 3, 6, 7]
      target: 7
    }
  }
}
