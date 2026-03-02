// Run job to test the max_stack function
run.job "Test Max Stack" {
  main = {
    name: "max_stack"
    input: {
      operations: ["push", "push", "push", "getMax", "pop", "top", "getMax"]
      values: [5, 1, 3, null, null, null, null]
    }
  }
}
