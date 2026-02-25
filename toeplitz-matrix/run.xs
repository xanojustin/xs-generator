// Run job to test the is_toeplitz function
// Toeplitz Matrix: Checks if every diagonal from top-left to bottom-right has the same element
run.job "Test Toeplitz Matrix" {
  main = {
    name: "is_toeplitz"
    input: {
      matrix: [
        [1, 2, 3, 4],
        [5, 1, 2, 3],
        [9, 5, 1, 2]
      ]
    }
  }
}
