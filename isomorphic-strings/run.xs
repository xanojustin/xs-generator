// Run job to test isomorphic strings
// Checks if two strings are isomorphic (characters can be mapped to transform one to the other)
run.job "Test Isomorphic Strings" {
  main = {
    name: "isomorphic_strings"
    input: {
      s: "egg"
      t: "add"
    }
  }
}
