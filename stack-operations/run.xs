// Run job to test the stack_operations function
run.job "Test Stack Operations" {
  main = {
    name: "stack_operations"
    input: {
      stack: ["apple", "banana", "cherry"]
      operation: "push"
      value: "date"
    }
  }
}
