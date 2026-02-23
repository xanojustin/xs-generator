// Run job for Dijkstra Shortest Path Algorithm
// Tests the dijkstra function with various graph inputs
run.job "Dijkstra Shortest Path Test" {
  main = {
    name: "dijkstra"
    input: {
      graph: {
        "A": [
          { to: "B", weight: 4 },
          { to: "D", weight: 1 }
        ],
        "B": [
          { to: "A", weight: 4 },
          { to: "C", weight: 2 },
          { to: "E", weight: 3 }
        ],
        "C": [
          { to: "B", weight: 2 },
          { to: "F", weight: 1 }
        ],
        "D": [
          { to: "A", weight: 1 },
          { to: "E", weight: 2 }
        ],
        "E": [
          { to: "B", weight: 3 },
          { to: "D", weight: 2 },
          { to: "F", weight: 3 }
        ],
        "F": [
          { to: "C", weight: 1 },
          { to: "E", weight: 3 }
        ]
      }
      start_node: "A"
    }
  }
}