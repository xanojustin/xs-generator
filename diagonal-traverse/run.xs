// Run job to test the diagonal_traverse function
run.job "Test Diagonal Traverse" {
  main = {
    name: "diagonal_traverse"
    input: {
      matrix: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
  }
}
