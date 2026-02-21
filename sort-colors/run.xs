// Run job to test the sort-colors function
// Sorts an array of 0s, 1s, and 2s in-place using the Dutch National Flag algorithm
run.job "Test Sort Colors" {
  main = {
    name: "sort-colors"
    input: {
      nums: [2, 0, 2, 1, 1, 0]
    }
  }
}
