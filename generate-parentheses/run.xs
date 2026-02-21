// Run job to test the generate_parentheses function
run.job "Test Generate Parentheses" {
  main = {
    name: "generate_parentheses"
    input: {
      n: 3
    }
  }
}
