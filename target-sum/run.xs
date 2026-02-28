// Run job to test the target_sum function
// Target Sum: Count ways to assign + or - to each number to reach target
run.job "Test Target Sum" {
  main = {
    name: "target_sum"
    input: {
      nums: [1, 1, 1, 1, 1]
      target: 3
    }
  }
}
