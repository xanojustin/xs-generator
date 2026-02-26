// Run job to test the shuffle_array function
run.job "Test Shuffle Array" {
  main = {
    name: "shuffle_array"
    input: {
      nums: [2, 5, 1, 3, 4, 7]
      n: 3
    }
  }
}
