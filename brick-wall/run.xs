// Run job to test the brick_wall function
// Brick Wall: Find the vertical line that crosses the minimum number of bricks
run.job "Test Brick Wall" {
  main = {
    name: "brick_wall"
    input: {
      wall: [
        [1, 2, 2, 1],
        [3, 1, 2],
        [1, 3, 2],
        [2, 4],
        [3, 1, 2],
        [1, 3, 1, 1]
      ]
    }
  }
}
