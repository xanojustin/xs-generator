// Run job to test the regular-expression-matching function
// Tests various string and pattern combinations
run.job "Test Regular Expression Matching" {
  main = {
    name: "regular-expression-matching"
    input: {
      s: "aa"
      p: "a*"
    }
  }
}
