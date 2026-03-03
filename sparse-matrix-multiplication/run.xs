run.job "Sparse Matrix Multiplication Test" {
  main = {
    name: "sparse_matrix_multiply"
    input: { 
      matrix_a: [
        { row: 1, col: 1, value: 4 },
        { row: 1, col: 3, value: 2 },
        { row: 2, col: 2, value: 3 }
      ]
      matrix_b: [
        { row: 1, col: 1, value: 4 },
        { row: 2, col: 2, value: 5 },
        { row: 3, col: 1, value: 6 },
        { row: 3, col: 2, value: 7 }
      ]
      a_rows: 2
      a_cols: 3
      b_cols: 2
    }
  }
}
