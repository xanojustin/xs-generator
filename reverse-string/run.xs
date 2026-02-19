// Run job to test the reverse_string function
run.job "Test Reverse String" {
  main = {
    name: "reverse_string"
    input: {
      input_string: "hello"
    }
  }
}
