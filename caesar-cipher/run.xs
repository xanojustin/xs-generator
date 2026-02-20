// Run job to test the caesar-cipher function
run.job "Test Caesar Cipher" {
  main = {
    name: "caesar-cipher"
    input: {
      message: "Hello, World!"
      shift: 3
    }
  }
}
