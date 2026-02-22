// Sudoku Solver - Classic backtracking algorithm
// Solves a 9x9 Sudoku puzzle by filling empty cells (0 represents empty)
function "sudoku_solver" {
  description = "Solves a 9x9 Sudoku puzzle using backtracking"
  
  input {
    json board { description = "9x9 grid with 0 representing empty cells" }
  }
  
  stack {
    function.run "solve_helper" {
      input = { board: $input.board }
    } as $solution
  }
  
  response = $solution
}