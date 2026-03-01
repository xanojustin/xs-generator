// Run job to test the count_binary_substrings function
run.job "Test Count Binary Substrings" {
  main = {
    name: "count_binary_substrings"
    input: {
      binary_string: "00110011"
    }
  }
}
