// Run job to test the stone_game function
// Stone Game: Determine if the first player wins given optimal play
run.job "Test Stone Game" {
  main = {
    name: "stone_game"
    input: {
      piles: [5, 3, 4, 5]
    }
  }
}
