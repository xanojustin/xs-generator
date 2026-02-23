// Run job to test the longest_valid_parentheses function
// Longest Valid Parentheses: Find the length of the longest valid parentheses substring
run.job "Test Longest Valid Parentheses" {
  main = {
    name: "longest_valid_parentheses"
    input: {
      s: "(()"
    }
  }
}
