// Run job to test the number of islands function
run.job "Test Number of Islands" {
  main = {
    name: "count_islands"
    input: {
      grid: [
        [1, 1, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 1, 1]
      ]
    }
  }
}
