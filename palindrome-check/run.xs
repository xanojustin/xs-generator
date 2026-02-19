// Run job to test the palindrome_check function
run.job "Test Palindrome Check" {
  main = {
    name: "palindrome_check"
    input: {
      input_string: "A man a plan a canal Panama"
    }
  }
}
