// Run job to test the add_binary function
// Add Binary: Given two binary strings, return their sum (also a binary string)
run.job "Test Add Binary" {
  main = {
    name: "add_binary"
    input: {
      a: "11"
      b: "1"
    }
  }
}
