// Run job to test the string compression function
run.job "Test String Compression" {
  main = {
    name: "string-compression"
    input: {
      str: "aaabbc"
    }
  }
}
