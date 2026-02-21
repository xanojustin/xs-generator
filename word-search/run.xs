// Run job to test the word_search function
// Word Search: Determine if a word exists in a 2D grid of letters
run.job "Test Word Search" {
  main = {
    name: "word_search"
    input: {
      grid: [
        ["A", "B", "C", "E"],
        ["S", "F", "C", "S"],
        ["A", "D", "E", "E"]
      ]
      word: "ABCCED"
    }
  }
}
