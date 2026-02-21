// Run job to test the find_missing_number function
run.job "Test Find Missing Number" {
  main = {
    name: "find_missing_number"
    input: {
      nums: [3, 0, 1]
    }
  }
}
