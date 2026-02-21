// Run job to test the reverse-integer function with multiple test cases
run.job "Reverse Integer Test" {
  main = {
    name: "reverse-integer"
    input: {
      x: 123
    }
  }
}
