// Run job to test the partition_equal_subset_sum function
// Partition Equal Subset Sum: Determine if array can be split into two subsets with equal sum
run.job "Test Partition Equal Subset Sum" {
  main = {
    name: "partition_equal_subset_sum"
    input: {
      nums: [1, 5, 11, 5]
    }
  }
}
