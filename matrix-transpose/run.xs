run.job "Matrix Transpose" {
  main = {
    name: "transpose_matrix"
    input: {
      matrix: [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
    }
  }
}
