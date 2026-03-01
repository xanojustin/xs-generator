// Run job to test the number-to-hexadecimal function
run.job "Test Number to Hexadecimal" {
  main = {
    name: "number-to-hexadecimal"
    input: {
      num: 26
    }
  }
}
