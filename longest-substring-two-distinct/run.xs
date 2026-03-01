// Run job to test the longest substring with at most two distinct characters function
run.job "Test Longest Substring Two Distinct" {
  main = {
    name: "longest_substring_two_distinct"
    input: {
      s: "eceba"
    }
  }
}
