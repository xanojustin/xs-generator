// Run job to test the Union-Find (Disjoint Set Union) data structure
// Tests: find with path compression, union by rank, and connected checks
run.job "Test Union-Find" {
  main = {
    name: "union_find"
    input: {
      n: 10
      operations: [
        { type: "union", params: [0, 1] }
        { type: "union", params: [1, 2] }
        { type: "find", params: [0] }
        { type: "connected", params: [0, 2] }
        { type: "connected", params: [0, 3] }
        { type: "union", params: [3, 4] }
        { type: "union", params: [4, 5] }
        { type: "union", params: [2, 5] }
        { type: "connected", params: [0, 5] }
        { type: "find", params: [3] }
      ]
    }
  }
}