// Run job to test the matrix diagonal sum function
run.job "Test Matrix Diagonal Sum" {
  main = {
    name: "matrix_diagonal_sum"
    input: {
      matrix: [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
    }
  }
}
