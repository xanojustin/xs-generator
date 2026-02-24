// Run job to test the reshape matrix function
run.job "Test Reshape Matrix" {
  main = {
    name: "reshape_matrix"
    input: {
      mat: [[1, 2], [3, 4]]
      r: 1
      c: 4
    }
  }
}
