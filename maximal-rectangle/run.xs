// Run job to test the maximal rectangle function
run.job "Test Maximal Rectangle" {
  main = {
    name: "maximal_rectangle"
    input: {
      matrix: [
        [1, 0, 1, 0, 0],
        [1, 0, 1, 1, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 1, 0]
      ]
    }
  }
}
