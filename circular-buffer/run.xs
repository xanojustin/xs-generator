// Run job to test the circular_buffer function
// Demonstrates a complete workflow: write items, read items, test edge cases
run.job "Test Circular Buffer" {
  main = {
    name: "circular_buffer"
    input: {
      operation: "write"
      capacity: 3
      buffer: []
      read_index: 0
      write_index: 0
      item: 10
    }
  }
}
