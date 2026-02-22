// Run job to test the add_strings function
// Add Strings: Add two non-negative integers represented as strings
run.job "Test Add Strings" {
  main = {
    name: "add_strings"
    input: {
      num1: "123"
      num2: "456"
    }
  }
}
