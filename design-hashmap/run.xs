// Run job to test the design_hashmap function
// Design HashMap: Implements a basic hash map with put, get, and remove operations
run.job "Test Design HashMap" {
  main = {
    name: "design_hashmap"
    input: {
      operation: "put"
      key: 1
      value: 10
      hashmap: { buckets: [], size: 0 }
    }
  }
}
