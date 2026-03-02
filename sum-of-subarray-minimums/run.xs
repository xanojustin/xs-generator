// Run job to test the sum_of_subarray_minimums function
// Sum of Subarray Minimums: Given an array, find sum of min values in all subarrays
run.job "Test Sum of Subarray Minimums" {
  main = {
    name: "sum_of_subarray_minimums"
    input: {
      arr: [3, 1, 2, 4]
    }
  }
}
