// Run job to test the shortest bridge function
run.job "Test Shortest Bridge" {
  main = {
    name: "shortest_bridge"
    input: {
      grid: [
        [0, 1, 0],
        [0, 0, 0],
        [0, 0, 1]
      ]
    }
  }
}
