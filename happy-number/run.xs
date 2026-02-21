// Run job to test the happy number function with multiple test cases
run.job "Test Happy Number" {
  main = {
    name: "is_happy_number"
    input: {
      n: 19
    }
  }
}
