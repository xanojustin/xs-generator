run.job "Word Pattern Test" {
  main = {
    name: "word_pattern"
    input: {
      pattern: "abba"
      s: "dog cat cat dog"
    }
  }
}
