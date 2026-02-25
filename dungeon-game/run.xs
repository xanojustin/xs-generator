// Run job to test the dungeon_game function
run.job "Test Dungeon Game" {
  main = {
    name: "dungeon_game"
    input: {
      dungeon: [
        [-2, -3, 3],
        [-5, -10, 1],
        [10, 30, -5]
      ]
    }
  }
}
