// Run job to test the matrix transpose function
run.job "Test Matrix Transpose" {
  main = {
    name: "matrix_transpose"
    input: {
      matrix: [[1, 2, 3], [4, 5, 6]]
    }
  }
}
