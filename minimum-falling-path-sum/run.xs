// Run job to test the minimum falling path sum function
run.job "Test Minimum Falling Path Sum" {
  main = {
    name: "minimum_falling_path_sum"
    input: {
      matrix: [[2, 1, 3], [6, 5, 4], [7, 8, 9]]
    }
  }
}
