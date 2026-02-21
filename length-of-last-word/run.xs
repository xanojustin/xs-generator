// Run job to test the length_of_last_word function
// Length of Last Word: Return the length of the last word in a string
run.job "Test Length of Last Word" {
  main = {
    name: "length_of_last_word"
    input: {
      s: "Hello World"
    }
  }
}
