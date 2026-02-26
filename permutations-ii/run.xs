// Run job to test the permutations_ii function
// Permutations II: Generate all unique permutations of a list with possible duplicates
run.job "Test Permutations II" {
  main = {
    name: "permutations_ii"
    input: {
      nums: [1, 1, 2]
    }
  }
}
