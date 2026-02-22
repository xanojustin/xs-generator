// Run job to test the minimum_window_substring function
// Minimum Window Substring: Find the smallest substring containing all chars from t
run.job "Test Minimum Window Substring" {
  main = {
    name: "minimum_window_substring"
    input: {
      s: "ADOBECODEBANC"
      t: "ABC"
    }
  }
}
