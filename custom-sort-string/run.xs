run.job "Test custom-sort-string" {
  main = {
    name: "custom-sort-string"
    input: {
      order: "cba"
      s: "abcd"
    }
  }
}