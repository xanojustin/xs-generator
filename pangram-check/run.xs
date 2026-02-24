// Run job to test the is_pangram function
// Pangram Check: Determine if a sentence contains every letter of the alphabet at least once
run.job "Test Pangram Check" {
  main = {
    name: "is_pangram"
    input: {
      text: "The quick brown fox jumps over the lazy dog"
    }
  }
}
