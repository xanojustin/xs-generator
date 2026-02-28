// Run job to test the matrix-block-sum function
run.job "Test Matrix Block Sum" {
  main = {
    name: "matrix-block-sum"
    input: {
      matrix: [[1,2,3],[4,5,6],[7,8,9]]
      k: 1
    }
  }
}
