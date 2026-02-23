run.job "K-Diff Pairs Runner" {
  main = {
    name: "count_k_diff_pairs"
    input: {
      nums: [3, 1, 4, 1, 5]
      k: 2
    }
  }
}
