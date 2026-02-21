// Run job to test the integer-to-roman function
run.job "Test Integer to Roman" {
  main = {
    name: "integer-to-roman"
    input: {
      number: 1994
    }
  }
}
