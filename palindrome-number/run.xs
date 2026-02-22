// run.xs - Run job that tests the palindrome-number function
run.job "Test Palindrome Number" {
  main = {
    name: "palindrome-number"
    input: {
      num: 121
    }
  }
}
