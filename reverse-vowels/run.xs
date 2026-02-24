// Run job to test the reverse_vowels function
run.job "Test Reverse Vowels" {
  main = {
    name: "reverse_vowels"
    input: {
      s: "hello"
    }
  }
}
