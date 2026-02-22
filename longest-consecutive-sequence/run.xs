// Run job to test the longest consecutive sequence function
run.job "Test Longest Consecutive Sequence" {
  main = {
    name: "longest_consecutive_sequence"
    input: {
      nums: [100, 4, 200, 1, 3, 2]
    }
  }
}
