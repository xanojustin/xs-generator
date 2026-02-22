// Run job to test the min_stack function
run.job "Test Min Stack" {
  main = {
    name: "min_stack"
    input: {
      operations: ["push", "push", "push", "getMin", "pop", "top", "getMin"]
      values: [-2, 0, -3, null, null, null, null]
    }
  }
}
