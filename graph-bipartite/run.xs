// Run job to test the is_bipartite function
run.job "Graph Bipartite Test" {
  main = {
    name: "is_bipartite"
    input: {
      graph: [[1,3],[0,2],[1,3],[0,2]]
    }
  }
}
