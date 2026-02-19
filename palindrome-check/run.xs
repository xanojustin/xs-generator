run.job "Palindrome Check Test" {
  main = {
    name: "check_palindrome"
    input: {
      text: "A man a plan a canal Panama"
    }
  }
}
