// Run job to test the valid_parentheses function
run.job "Test Valid Parentheses" {
  main = {
    name: "valid_parentheses"
    input: {
      s: "()"
    }
  }
}
