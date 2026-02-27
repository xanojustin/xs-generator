// Conway's Game of Life - Classic cellular automaton simulation
// Simulates the next state of a cell board based on neighbor counts
function "game_of_life" {
  description = "Simulates one generation of Conway's Game of Life"

  input {
    json board { description = "2D array where 1 = live cell, 0 = dead cell" }
  }

  stack {
    // Handle empty board
    var $rows { value = $input.board|count }
    conditional {
      if ($rows == 0) {
        return { value = [] }
      }
    }

    var $cols { value = $input.board[0]|count }
    conditional {
      if ($cols == 0) {
        return { value = [] }
      }
    }

    // Create a copy of the board for the next state
    var $next_board { value = [] }
    var $r { value = 0 }
    while ($r < $rows) {
      each {
        var $new_row { value = [] }
        var $c { value = 0 }
        while ($c < $cols) {
          each {
            array.push $new_row {
              value = $input.board[$r][$c]
            }
            math.add $c { value = 1 }
          }
        }
        array.push $next_board {
          value = $new_row
        }
        math.add $r { value = 1 }
      }
    }

    // Process each cell
    var $i { value = 0 }
    while ($i < $rows) {
      each {
        var $j { value = 0 }
        while ($j < $cols) {
          each {
            // Count live neighbors
            var $live_neighbors { value = 0 }
            
            // Check all 8 directions
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
                    
                    var $ni { value = $i + $di }
                    var $nj { value = $j + $dj }
                    
                    // Check bounds
                    conditional {
                      if ($ni >= 0 && $ni < $rows && $nj >= 0 && $nj < $cols) {
                        conditional {
                          if ($input.board[$ni][$nj] == 1) {
                            math.add $live_neighbors { value = 1 }
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
            
            // Apply Game of Life rules
            var $current_cell { value = $input.board[$i][$j] }
            
            conditional {
              // Rule 1 & 3: Live cell with < 2 or > 3 neighbors dies
              if ($current_cell == 1) {
                conditional {
                  if ($live_neighbors < 2 || $live_neighbors > 3) {
                    var.update $next_board[$i] { 
                      value = $next_board[$i]|set:$j:0 
                    }
                  }
                }
              }
              // Rule 4: Dead cell with exactly 3 neighbors becomes alive
              else {
                conditional {
                  if ($live_neighbors == 3) {
                    var.update $next_board[$i] { 
                      value = $next_board[$i]|set:$j:1 
                    }
                  }
                }
              }
            }
            
            math.add $j { value = 1 }
          }
        }
        math.add $i { value = 1 }
      }
    }
  }

  response = $next_board
}
