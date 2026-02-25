// Run job to test the missing_ranges function
// Missing Ranges: Find all missing ranges in a sorted unique array within [lower, upper] bounds
run.job "Test Missing Ranges" {
  main = {
    name: "missing_ranges"
    input: {
      nums: [0, 1, 3, 50, 75]
      lower: 0
      upper: 99
    }
  }
}
