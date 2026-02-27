// Run job to test the kth_smallest_sorted_matrix function
// Kth Smallest Element in Sorted Matrix: Find kth smallest in n x n sorted matrix
run.job "Test Kth Smallest Sorted Matrix" {
  main = {
    name: "kth_smallest_sorted_matrix"
    input: {
      matrix: {
        rows: [
          { values: [1, 5, 9] }
          { values: [10, 11, 13] }
          { values: [12, 13, 15] }
        ]
      }
      k: 8
    }
  }
}
