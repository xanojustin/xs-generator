// Run job to test the largest_divisible_subset function
run.job "Test Largest Divisible Subset" {
  main = {
    name: "largest_divisible_subset"
    input: {
      nums: [1, 2, 3, 4, 8, 12]
    }
  }
}
