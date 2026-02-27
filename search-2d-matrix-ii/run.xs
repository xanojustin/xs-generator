// Run job to test the search_2d_matrix_ii function
// Search a 2D Matrix II: Search for target in a matrix where each row and column is sorted
run.job "Test Search 2D Matrix II" {
  main = {
    name: "search_2d_matrix_ii"
    input: {
      matrix: [
        [1, 4, 7, 11, 15],
        [2, 5, 8, 12, 19],
        [3, 6, 9, 16, 22],
        [10, 13, 14, 17, 24],
        [18, 21, 23, 26, 30]
      ]
      target: 5
    }
  }
}
