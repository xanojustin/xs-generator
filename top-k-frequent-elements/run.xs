run.job "Top K Frequent Elements" {
  main = {
    name: "top_k_frequent"
    input: {
      nums: [1, 1, 1, 2, 2, 3]
      k: 2
    }
  }
}
