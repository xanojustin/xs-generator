// Run job to test the next greater element function
run.job "Test Next Greater Element" {
  main = {
    name: "next_greater_element"
    input: {
      nums: [4, 5, 2, 25]
    }
  }
}
