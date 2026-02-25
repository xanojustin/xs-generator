// Run job to test the valid_perfect_square function
// Tests various inputs including perfect squares and non-perfect squares
run.job "Test Valid Perfect Square" {
  main = {
    name: "valid_perfect_square"
    input: {
      num: 16
    }
  }
}
