// Run job to test the max_consecutive_ones_ii function
// Max Consecutive Ones II: Find max consecutive 1s with at most one 0 flip
run.job "Test Max Consecutive Ones II" {
  main = {
    name: "max_consecutive_ones_ii"
    input: {
      nums: [1, 0, 1, 1, 0]
    }
  }
}
