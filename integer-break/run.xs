// Run job to test the integer-break function
run.job "Test Integer Break" {
  main = {
    name: "integer-break"
    input: {
      n: 10
    }
  }
}
