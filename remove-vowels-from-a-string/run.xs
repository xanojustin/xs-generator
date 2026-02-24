// Run job to test the remove_vowels function
run.job "Test Remove Vowels" {
  main = {
    name: "remove_vowels"
    input: {
      input_string: "Hello World"
    }
  }
}
