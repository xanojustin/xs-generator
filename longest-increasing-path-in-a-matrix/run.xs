run.job "Longest Increasing Path Test" {
  main = {
    name: "longest_increasing_path"
    input: {
      matrix: [
        [9, 9, 4],
        [6, 6, 8],
        [2, 1, 1]
      ]
    }
  }
}
