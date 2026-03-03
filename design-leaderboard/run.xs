// Run job to test the leaderboard design
// Tests add_score, top(K), and reset operations
run.job "Test Leaderboard" {
  main = {
    name: "leaderboard"
    input: {
      operation: "add_score"
      player_id: 1
      score: 100
      k: 0
      initial_scores: {}
    }
  }
}
