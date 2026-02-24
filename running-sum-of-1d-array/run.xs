// Run job to test the running_sum function
run.job "Test Running Sum" {
  main = {
    name: "running_sum"
    input: {
      nums: [1, 2, 3, 4]
    }
  }
}
