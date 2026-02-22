// Run job to test the reverse_bits function
run.job "Test Reverse Bits" {
  main = {
    name: "reverse_bits"
    input: {
      n: 43261596
    }
  }
}
