// Run job to test the 3Sum function
run.job "Test 3Sum" {
  main = {
    name: "three_sum"
    input: {
      nums: [-1, 0, 1, 2, -1, -4]
    }
  }
}
