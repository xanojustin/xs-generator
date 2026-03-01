// Run job to test the minesweeper function
run.job "Test Minesweeper" {
  main = {
    name: "minesweeper"
    input: {
      board: [
        ["E", "E", "E", "E", "E"],
        ["E", "E", "M", "E", "E"],
        ["E", "E", "E", "E", "E"],
        ["E", "E", "E", "E", "E"]
      ]
      click: [3, 0]
    }
  }
}
