// Run job to test the Gray Code generator
run.job "Test Gray Code" {
  main = {
    name: "gray_code"
    input: {
      n: 3
    }
  }
}
