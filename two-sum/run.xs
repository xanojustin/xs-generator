// Run job to test the two_sum function
// Two Sum: Find indices of two numbers that add up to target
run.job "Test Two Sum" {
  main = {
    name: "two_sum"
    input: {
      nums: [2, 7, 11, 15]
      target: 9
    }
  }
}
