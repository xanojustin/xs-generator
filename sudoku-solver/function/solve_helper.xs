// Recursive backtracking solver for Sudoku
function "solve_helper" {
  description = "Recursively solves the Sudoku puzzle using backtracking"
  
  input {
    json board { description = "9x9 Sudoku board to solve" }
  }
  
  stack {
    // Find next empty cell
    function.run "find_empty" {
      input = { board: $input.board }
    } as $empty_result
    
    var $result { value = { solved: false, board: $input.board } }
    var $board { value = $input.board }
    
    conditional {
      // If no empty cell found, puzzle is solved
      if (!$empty_result.found) {
        var $result {
          value = {
            solved: true,
            board: $board
          }
        }
      }
      else {
        var $row { value = $empty_result.row }
        var $col { value = $empty_result.col }
        var $num { value = 1 }
        var $solved { value = false }
        
        // Try numbers 1-9
        while ($num <= 9 && !$solved) {
          each {
            // Check if placement is valid
            function.run "is_valid" {
              input = {
                board: $board,
                row: $row,
                col: $col,
                num: $num
              }
            } as $valid_result
            
            conditional {
              if ($valid_result) {
                // Place the number: board[row][col] = num
                var $board {
                  value = $board|set:$row:($board|get:$row|set:$col:$num)
                }
                
                // Recursively solve
                function.run "solve_helper" {
                  input = { board: $board }
                } as $solve_result
                
                conditional {
                  if ($solve_result.solved) {
                    var $result {
                      value = {
                        solved: true,
                        board: $solve_result.board
                      }
                    }
                    var $solved { value = true }
                  }
                }
                
                // Backtrack - reset cell to empty (only if not solved)
                conditional {
                  if (!$solved) {
                    var $board {
                      value = $board|set:$row:($board|get:$row|set:$col:0)
                    }
                  }
                }
              }
            }
            
            conditional {
              if (!$solved) {
                var.update $num { value = $num + 1 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $result
}