// Helper function to check if placing num at board[row][col] is valid
function "is_valid" {
  description = "Checks if placing a number at a specific position is valid"
  
  input {
    json board { description = "9x9 Sudoku board" }
    int row { description = "Row index (0-8)" }
    int col { description = "Column index (0-8)" }
    int num { description = "Number to place (1-9)" }
  }
  
  stack {
    var $valid { value = true }
    var $i { value = 0 }
    
    // Check row - ensure num doesn't already exist in the row
    while ($i < 9 && $valid) {
      each {
        conditional {
          if ($input.board[$input.row][$i] == $input.num) {
            var $valid { value = false }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Check column - ensure num doesn't already exist in the column
    var $i { value = 0 }
    while ($i < 9 && $valid) {
      each {
        conditional {
          if ($input.board[$i][$input.col] == $input.num) {
            var $valid { value = false }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Check 3x3 box
    var $box_row { value = ($input.row / 3) * 3 }
    var $box_col { value = ($input.col / 3) * 3 }
    var $r { value = $box_row }
    
    while ($r < $box_row + 3 && $valid) {
      each {
        var $c { value = $box_col }
        while ($c < $box_col + 3 && $valid) {
          each {
            conditional {
              if ($input.board[$r][$c] == $input.num) {
                var $valid { value = false }
              }
            }
            var.update $c { value = $c + 1 }
          }
        }
        var.update $r { value = $r + 1 }
      }
    }
  }
  
  response = $valid
}