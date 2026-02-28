run.job "Verify Alien Dictionary Tests" {
  main = {
    name: "verify_alien_dictionary"
    input: {
      words: ["hello", "leetcode"],
      order: "hlabcdefgijkmnopqrstuvwxyz"
    }
  }
}
