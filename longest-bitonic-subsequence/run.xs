// Run job to test the longest_bitonic_subsequence function
run.job "Test Longest Bitonic Subsequence" {
  main = {
    name: "longest_bitonic_subsequence"
    input: {
      nums: [1, 11, 2, 10, 4, 5, 2, 1]
    }
  }
}
