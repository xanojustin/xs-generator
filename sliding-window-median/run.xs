run.job "Sliding Window Median Test" {
  main = {
    name: "sliding_window_median"
    input: {
      nums: [1, 3, -1, -3, 5, 3, 6, 7],
      k: 3
    }
  }
}
