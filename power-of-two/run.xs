// Run job to test the is_power_of_two function
run.job "Test Power of Two" {
  main = {
    name: "is_power_of_two"
    input: {
      n: 16
    }
  }
}
