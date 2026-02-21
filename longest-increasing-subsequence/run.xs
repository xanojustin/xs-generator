// Run job to test the longest_increasing_subsequence function
run.job "Test Longest Increasing Subsequence" {
  main = {
    name: "longest_increasing_subsequence"
    input: {
      nums: [10, 9, 2, 5, 3, 7, 101, 18]
    }
  }
}
