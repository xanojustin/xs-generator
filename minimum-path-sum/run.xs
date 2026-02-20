// Run job to test the minimum path sum function
run.job "Test Minimum Path Sum" {
  main = {
    name: "minimum_path_sum"
    input: {
      grid: [
        [1, 3, 1],
        [1, 5, 1],
        [4, 2, 1]
      ]
    }
  }
}
