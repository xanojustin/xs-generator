// Run job to test the sum_of_subarray_ranges function
run.job "Sum of Subarray Ranges Calculator" {
  main = {
    name: "sum_of_subarray_ranges"
    input: {
      nums: [1, 2, 3]
    }
  }
}
