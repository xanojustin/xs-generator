// Run job to test the letter case permutation function
// Generates all possible strings by changing the case of every letter
run.job "Test Letter Case Permutation" {
  main = {
    name: "letter_case_permutation"
    input: {
      s: "a1b2"
    }
  }
}
