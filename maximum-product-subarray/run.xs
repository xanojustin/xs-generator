// Run job to test the maximum product subarray function
run.job "Test Maximum Product Subarray" {
  main = {
    name: "maximum_product_subarray"
    input: {
      nums: [2, 3, -2, 4]
    }
  }
}
