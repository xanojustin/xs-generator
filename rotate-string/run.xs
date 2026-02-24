// Run job to test the rotate_string function
run.job "Test Rotate String" {
  main = {
    name: "rotate_string"
    input: {
      s1: "abcde"
      s2: "cdeab"
    }
  }
}