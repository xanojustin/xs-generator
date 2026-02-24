// Run job to test the four_sum function
// Four Sum: Find all unique quadruplets that sum to target
run.job "Test Four Sum" {
  main = {
    name: "four_sum"
    input: {
      nums: [1, 0, -1, 0, -2, 2]
      target: 0
    }
  }
}
