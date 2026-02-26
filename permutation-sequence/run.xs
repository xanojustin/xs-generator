// Run job to test the permutation_sequence function
// Permutation Sequence: Find the kth permutation of numbers 1 to n
run.job "Test Permutation Sequence" {
  main = {
    name: "permutation_sequence"
    input: {
      n: 3
      k: 3
    }
  }
}
