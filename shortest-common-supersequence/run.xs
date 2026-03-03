run.job "shortest-common-supersequence-test" {
  main = {
    name: "shortest-common-supersequence"
    input: {
      str1: "abac"
      str2: "cab"
    }
  }
}