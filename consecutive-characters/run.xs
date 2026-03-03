// Run job to test the consecutive-characters function
// Tests various strings to find the maximum consecutive repeating characters
run.job "Test Consecutive Characters" {
  main = {
    name: "consecutive-characters"
    input: {
      s: "leetcode"
    }
  }
}
