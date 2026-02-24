// Run job to test the stack_using_queues implementation
// Tests push, pop, peek, is_empty, and batch operations
run.job "Test Stack Using Queues" {
  main = {
    name: "stack_using_queues"
    input: {
      operation: "batch"
      payload: [
        { operation: "is_empty" },
        { operation: "push", value: 10 },
        { operation: "push", value: 20 },
        { operation: "push", value: 30 },
        { operation: "peek" },
        { operation: "pop" },
        { operation: "pop" },
        { operation: "is_empty" },
        { operation: "pop" },
        { operation: "pop" }
      ]
    }
  }
}
