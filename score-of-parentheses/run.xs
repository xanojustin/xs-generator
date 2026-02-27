// Run job to test the score_of_parentheses function
run.job "Test Score of Parentheses" {
  main = {
    name: "score_of_parentheses"
    input: {
      s: "(()(()))"
    }
  }
}
