// Run job to test the reverse_words function
run.job "Test Reverse Words" {
  main = {
    name: "reverse_words"
    input: {
      input_string: "the sky is blue"
    }
  }
}
