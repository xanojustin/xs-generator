// Run job to test the circular deque implementation
run.job "Test Circular Deque" {
  main = {
    name: "circularDeque"
    input: {
      capacity: 3
      operation: "create"
    }
  }
}
