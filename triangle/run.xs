run.job "Triangle Minimum Path Sum" {
  main = {
    name: "minimum_path_sum"
    input: {
      triangle: [
        [2],
        [3, 4],
        [6, 5, 7],
        [4, 1, 8, 3]
      ]
    }
  }
}
