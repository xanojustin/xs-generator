// Run job to test the N-Queens solver
// N-Queens: Place N queens on an N×N chessboard so that no two queens attack each other
run.job "Test N-Queens" {
  main = {
    name: "n_queens_test"
    input: {}
  }
}
