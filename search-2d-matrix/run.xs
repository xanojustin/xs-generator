// Run job to test the search_2d_matrix function
// Search a 2D Matrix: Search for a target value in a sorted 2D matrix
run.job "Test Search 2D Matrix" {
  main = {
    name: "search_2d_matrix"
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
