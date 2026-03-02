run.job "Shuffle String Test" {
  main = {
    name: "shuffle_string"
    input: {
      s: "codeleet"
      indices: [4, 5, 6, 7, 0, 2, 1, 3]
    }
  }
}
