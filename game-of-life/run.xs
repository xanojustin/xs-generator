// Run job to test the Game of Life function
run.job "Test Game of Life" {
  main = {
    name: "game_of_life"
    input: {
      board: [
        [0, 1, 0],
        [0, 1, 0],
        [0, 1, 0]
      ]
    }
  }
}
