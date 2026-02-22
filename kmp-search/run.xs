run.job "KMP Search Test" {
  main = {
    name: "kmp_search"
    input: {
      text: "ABABDABACDABABCABAB"
      pattern: "ABABCABAB"
    }
  }
}
