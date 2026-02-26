run.job "Find the Celebrity Test" {
  main = {
    name: "find_celebrity"
    input: {
      knows_matrix: [
        [0, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0],
        [0, 1, 1, 0]
      ]
      n: 4
    }
  }
}
