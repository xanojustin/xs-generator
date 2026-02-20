// Run job to test the Spiral Matrix function
run.job "Test Spiral Matrix" {
  main = {
    name: "spiral_matrix"
    input: {
      matrix: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
  }
}
