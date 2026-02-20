// Run job to test the first_non_repeating_character function
run.job "Test First Non-Repeating Character" {
  main = {
    name: "first_non_repeating_character"
    input: {
      s: "leetcode"
    }
  }
}
