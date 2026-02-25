// Run job to test the rotting-oranges function
run.job "Test Rotting Oranges" {
  main = {
    name: "rotting-oranges"
    input: {
      grid: [[2, 1, 1], [1, 1, 0], [0, 1, 1]]
    }
  }
}
