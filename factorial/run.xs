// Run job to test the factorial function
// Calculates factorial of a given non-negative integer
run.job "Test Factorial" {
  main = {
    name: "factorial"
    input: {
      n: 5
    }
  }
}
