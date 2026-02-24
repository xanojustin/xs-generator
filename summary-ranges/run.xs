// Run job to test the summary_ranges function
// Summary Ranges: Convert sorted unique array to compact range strings
run.job "Test Summary Ranges" {
  main = {
    name: "summary_ranges"
    input: {
      nums: [0, 1, 2, 4, 5, 7]
    }
  }
}
