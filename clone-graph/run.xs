run.job "Clone Graph Test" {
  main = {
    name: "clone-graph"
    input: {
      node: {
        val: 1,
        neighbors: [
          { val: 2, neighbors: [{ val: 1, neighbors: [] }, { val: 3, neighbors: [] }] },
          { val: 4, neighbors: [{ val: 1, neighbors: [] }, { val: 3, neighbors: [] }] }
        ]
      }
    }
  }
}
