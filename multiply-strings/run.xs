// Run job to test the multiply_strings function
// Multiply Strings: Multiply two non-negative integers represented as strings
run.job "Test Multiply Strings" {
  main = {
    name: "multiply_strings"
    input: {
      num1: "123"
      num2: "456"
    }
  }
}
