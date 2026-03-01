// Helper function to reveal a cell and recursively reveal adjacent cells
function "reveal_cell" {
  description = "Reveals a cell and recursively reveals adjacent empty cells"
  
  input {
    json board
    int row
    int col
    int rows
    int cols
  }
  
  stack {
    // Count adjacent mines
    var $mine_count { value = 0 }
    var $di { value = -1 }
    
    while ($di <= 1) {
      each {
        var $dj { value = -1 }
        while ($dj <= 1) {
          each {
            // Skip the cell itself
            conditional {
              if ($di == 0 && $dj == 0) {
                math.add $dj { value = 1 }
                continue
              }
            }
            
            var $ni { value = $input.row + $di }
            var $nj { value = $input.col + $dj }
            
            // Check bounds
            conditional {
              if ($ni >= 0 && $ni < $input.rows && $nj >= 0 && $nj < $input.cols) {
                var $neighbor { value = $input.board[$ni][$nj] }
                conditional {
                  if ($neighbor == "M" || $neighbor == "X") {
                    math.add $mine_count { value = 1 }
                  }
                }
              }
            }
            
            math.add $dj { value = 1 }
          }
        }
        math.add $di { value = 1 }
      }
    }
    
    // Update the current cell
    var $current_board { value = $input.board }
    
    conditional {
      if ($mine_count == 0) {
        // No adjacent mines - mark as blank and recurse
        var.update $current_board[$input.row] {
          value = $current_board[$input.row]|set:$input.col:"B"
        }
        
        // Recursively reveal all adjacent cells
        var $di2 { value = -1 }
        while ($di2 <= 1) {
          each {
            var $dj2 { value = -1 }
            while ($dj2 <= 1) {
              each {
                conditional {
                  if ($di2 == 0 && $dj2 == 0) {
                    math.add $dj2 { value = 1 }
                    continue
                  }
                }
                
                var $ni2 { value = $input.row + $di2 }
                var $nj2 { value = $input.col + $dj2 }
                
                // Check bounds and if cell is unrevealed empty
                conditional {
                  if ($ni2 >= 0 && $ni2 < $input.rows && $nj2 >= 0 && $nj2 < $input.cols) {
                    var $adjacent_cell { value = $current_board[$ni2][$nj2] }
                    conditional {
                      if ($adjacent_cell == "E") {
                        function.run "reveal_cell" {
                          input = {
                            board: $current_board,
                            row: $ni2,
                            col: $nj2,
                            rows: $input.rows,
                            cols: $input.cols
                          }
                        } as $sub_result
                        var $current_board { value = $sub_result }
                      }
                    }
                  }
                }
                
                math.add $dj2 { value = 1 }
              }
            }
            math.add $di2 { value = 1 }
          }
        }
      }
      else {
        // Has adjacent mines - mark with count
        var.update $current_board[$input.row] {
          value = $current_board[$input.row]|set:$input.col:($mine_count|to_text)
        }
      }
    }
  }
  
  response = $current_board
}
