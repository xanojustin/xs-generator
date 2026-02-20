run.job "Palindrome Check Test" {
  main = {
    name: "is_palindrome"
    input: {
      text: "A man a plan a canal Panama"
    }
  }
}