// Run job to test the longest_harmonious_subsequence function
// Longest Harmonious Subsequence: Find the longest subsequence where max - min = 1
run.job "Test Longest Harmonious Subsequence" {
  main = {
    name: "longest_harmonious_subsequence"
    input: {
      nums: [1, 3, 2, 2, 5, 2, 3, 7]
    }
  }
}