run.job "Sliding Window Minimum" {
  main = {
    name: "sliding_window_minimum"
    input: {
      nums: [1, 3, -1, -3, 5, 3, 6, 7],
      k: 3
    }
  }
}
