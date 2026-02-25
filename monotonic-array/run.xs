// Run job to test the monotonic-array function
run.job "Test Monotonic Array" {
  main = {
    name: "monotonic-array"
    input: {
      nums: [1, 2, 2, 3]
    }
  }
}
