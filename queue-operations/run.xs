// Run job to test the queue_operations function
run.job "Test Queue Operations" {
  main = {
    name: "queue_operations"
    input: {
      operation: "enqueue"
      queue: []
      item: 10
    }
  }
}
