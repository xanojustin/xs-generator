// Run job to test the surrounded-regions function
run.job "Test Surrounded Regions" {
  main = {
    name: "surrounded-regions"
    input: {
      board: [
        ["X", "X", "X", "X"],
        ["X", "O", "O", "X"],
        ["X", "X", "O", "X"],
        ["X", "O", "X", "X"]
      ]
    }
  }
}
