run.job "Find Path in Graph Test" {
  main = {
    name: "find_path"
    input: {
      n: 3
      edges: [
        {source: 0, target: 1}
        {source: 1, target: 2}
        {source: 2, target: 0}
      ]
      source: 0
      destination: 2
    }
  }
}
