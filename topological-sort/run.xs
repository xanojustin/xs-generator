// Run job to test the topological sort function
run.job "Test Topological Sort" {
  main = {
    name: "topological_sort"
    input: {
      num_nodes: 6
      edges: [[5, 2], [5, 0], [4, 0], [4, 1], [2, 3], [3, 1]]
    }
  }
}
