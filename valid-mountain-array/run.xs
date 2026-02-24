// Run job to test the valid-mountain-array function
run.job "Test Valid Mountain Array" {
  main = {
    name: "valid-mountain-array"
    input: {
      arr: [2, 1]
    }
  }
}
