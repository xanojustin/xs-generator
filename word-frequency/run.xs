// Run job to test the word-frequency function
run.job "Test Word Frequency Counter" {
  main = {
    name: "word-frequency"
    input: {
      text: "The quick brown fox jumps over the lazy dog the quick brown fox"
    }
  }
}
