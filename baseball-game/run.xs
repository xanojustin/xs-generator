// Run job to test the baseball game score calculator
run.job "Test Baseball Game" {
  main = {
    name: "calculate_score"
    input: {
      operations: ["5", "2", "C", "D", "+"]
    }
  }
}
