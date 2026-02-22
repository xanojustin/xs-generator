// Run job to test distinct_subsequences function
// Distinct Subsequences: Count how many times string t appears as a subsequence of string s
run.job "Test Distinct Subsequences" {
  main = {
    name: "distinct_subsequences"
    input: {
      s: "rabbbit"
      t: "rabbit"
    }
  }
}
