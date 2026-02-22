run.job "Wildcard Matching Test" {
  main = {
    name: "wildcard_match"
    input: {
      s: "aa"
      p: "a"
    }
  }
}
