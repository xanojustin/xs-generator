// Run job to test the longest common prefix function
run.job "Test Longest Common Prefix" {
  main = {
    name: "longest_common_prefix"
    input: {
      strings: ["flower", "flow", "flight"]
    }
  }
}
