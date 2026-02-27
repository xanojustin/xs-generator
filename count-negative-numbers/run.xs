// Run job to test the count_negative_numbers function
run.job "Test Count Negative Numbers" {
  main = {
    name: "count_negative_numbers"
    input: {
      grid: [
        [4, 3, 2, -1],
        [3, 2, 1, -1],
        [1, 1, -1, -2],
        [-1, -1, -2, -3]
      ]
    }
  }
}
