run.job "Substring with Concatenation" {
  main = {
    name: "substring_concatenation"
    input: {
      s: "barfoothefoobarman"
      words: ["foo", "bar"]
    }
  }
}
