// Run job to test the sliding window maximum function
run.job "Test Sliding Window Maximum" {
  main = {
    name: "sliding_window_maximum"
    input: {
      nums: [1, 3, -1, -3, 5, 3, 6, 7],
      k: 3
    }
  }
}
