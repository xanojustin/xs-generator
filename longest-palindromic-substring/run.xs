// Run job to test the longest_palindromic_substring function
// Longest Palindromic Substring: Find the longest substring that reads the same forwards and backwards
run.job "Test Longest Palindromic Substring" {
  main = {
    name: "longest_palindromic_substring"
    input: {
      s: "babad"
    }
  }
}
