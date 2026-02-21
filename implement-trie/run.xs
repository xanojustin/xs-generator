run.job "Test Trie Implementation" {
  main = {
    name: "implement_trie"
    input: {
      operations: ["insert", "search", "search", "startsWith", "insert", "search"]
      inputs: [
        {"word": "apple"},
        {"word": "apple"},
        {"word": "app"},
        {"prefix": "app"},
        {"word": "app"},
        {"word": "app"}
      ]
    }
  }
}