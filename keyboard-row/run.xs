// Run job to test the keyboard-row function
run.job "Test Keyboard Row" {
  main = {
    name: "keyboard-row"
    input: {
      words: ["Hello", "Alaska", "Dad", "Peace"]
    }
  }
}
