run.job "Find Center of Star Graph" {
  main = {
    name: "find_center"
    input: {
      edges: [[1, 2], [2, 3], [4, 2]]
    }
  }
}
