// Run job to test the string_to_integer_atoi function
run.job "Test String to Integer (atoi)" {
  main = {
    name: "string_to_integer_atoi"
    input: {
      s: "42"
    }
  }
}
