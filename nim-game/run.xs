// Run job to test the nim_game function
run.job "Test Nim Game" {
  main = {
    name: "nim_game"
    input: {
      n: 4
    }
  }
}
