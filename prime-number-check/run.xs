// Run job to test the prime number check function
run.job "Test Prime Number Check" {
  main = {
    name: "prime_number_check"
    input: {
      n: 17
    }
  }
}
