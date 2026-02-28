// Run job to test the minimum_absolute_difference function
// Finds the minimum absolute difference between any two elements in an array
run.job "Test Minimum Absolute Difference" {
  main = {
    name: "minimum_absolute_difference"
    input: {
      nums: [4, 2, 1, 3]
    }
  }
}
