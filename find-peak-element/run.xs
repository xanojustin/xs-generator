// Run job to test the find_peak_element function
// Find Peak Element: Find an index of a peak element (greater than neighbors)
run.job "Test Find Peak Element" {
  main = {
    name: "find_peak_element"
    input: {
      nums: [1, 2, 3, 1]
    }
  }
}
