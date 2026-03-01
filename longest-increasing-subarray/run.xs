// Run job to test the longest increasing subarray function
run.job "Test Longest Increasing Subarray" {
  main = {
    name: "longest_increasing_subarray"
    input: {
      nums: [1, 3, 5, 4, 7]
    }
  }
}
