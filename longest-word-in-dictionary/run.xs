run.job "Longest Word in Dictionary" {
  main = {
    name: "longest_word"
    input: {
      words: ["w", "wo", "wor", "word", "world", "worl"]
    }
  }
}
