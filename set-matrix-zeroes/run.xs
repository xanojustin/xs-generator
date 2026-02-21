// Run job to test the set matrix zeroes function
run.job "Test Set Matrix Zeroes" {
  main = {
    name: "set_matrix_zeroes"
    input: {
      matrix: [[1, 1, 1], [1, 0, 1], [1, 1, 1]]
    }
  }
}
