run.job "Implement StrStr Test" {
  main = {
    name: "strstr"
    input: {
      haystack: "hello world"
      needle: "world"
    }
  }
}
