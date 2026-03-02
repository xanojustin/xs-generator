// Run job to test the design stack with increment operation
run.job "Test Design Stack With Increment" {
  main = {
    name: "design_stack_increment"
    input: {
      operations: ["push","push","push","increment","increment","pop","pop"]
      values: [[1],[2],[3],[2,100],[3,200],[],[]]
    }
  }
}
