run.job "Shortest Word Distance Test" {
  main = {
    name: "shortest_word_distance"
    input: {
      words: ["practice", "makes", "perfect", "coding", "makes"]
      word1: "coding"
      word2: "practice"
    }
  }
}
