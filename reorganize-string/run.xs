// Run job to test the reorganize_string function
run.job "Test Reorganize String" {
  main = {
    name: "reorganize_string"
    input: {
      s: "aab"
    }
  }
}
