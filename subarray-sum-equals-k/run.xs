// Run job to test the subarray_sum function
// Subarray Sum Equals K: Count continuous subarrays with sum equal to k
run.job "Test Subarray Sum" {
  main = {
    name: "subarray_sum"
    input: {
      nums: [1, 1, 1]
      k: 2
    }
  }
}
