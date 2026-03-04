// Run job to test the subarray_sum_equals_k function
// Subarray Sum Equals K: Count subarrays with sum equal to k
run.job "Test Subarray Sum Equals K" {
  main = {
    name: "subarray_sum_equals_k"
    input: {
      nums: [1, 1, 1]
      k: 2
    }
  }
}
