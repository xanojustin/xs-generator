// Run job to test the decode_ways function
// Decode Ways: Count the number of ways to decode a digit string
run.job "Test Decode Ways" {
  main = {
    name: "decode_ways"
    input: {
      s: "12"
    }
  }
}
