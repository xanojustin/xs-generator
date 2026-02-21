// Run job to test the permutations function
// Generates all permutations of a given array of distinct integers
run.job "Test Permutations" {
  main = {
    name: "permutations"
    input: {
      nums: [1, 2, 3]
    }
  }
}
