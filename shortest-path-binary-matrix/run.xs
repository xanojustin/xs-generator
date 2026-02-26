// Run job to test the shortest path in binary matrix function
run.job "Test Shortest Path in Binary Matrix" {
  main = {
    name: "shortest_path"
    input: {
      grid: [
        [0, 1, 0, 0, 0],
        [0, 1, 0, 1, 0],
        [0, 0, 0, 1, 0],
        [1, 1, 0, 1, 0],
        [0, 0, 0, 0, 0]
      ]
    }
  }
}
