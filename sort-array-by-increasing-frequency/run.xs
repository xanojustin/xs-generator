// Run job to test the sort_by_frequency function
run.job "Test Sort by Frequency" {
  main = {
    name: "sort_by_frequency"
    input: {
      nums: [1, 1, 2, 2, 2, 3]
    }
  }
}
