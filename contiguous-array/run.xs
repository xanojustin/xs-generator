// Run job to test the contiguous array function
// Finds the longest contiguous subarray with equal number of 0s and 1s
run.job "Test Contiguous Array" {
  main = {
    name: "find_max_length"
    input: {
      nums: [0, 1]
    }
  }
}
