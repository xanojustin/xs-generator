// Run job to test the maximum subarray function
run.job "Test Maximum Subarray" {
  main = {
    name: "maximum_subarray"
    input: {
      nums: [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    }
  }
}
