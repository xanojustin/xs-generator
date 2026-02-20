// N-Queens Is Safe Helper
// Checks if placing a queen at (row, col) is safe given current board state
function "n_queens_is_safe" {
  description = "Checks if a queen can be safely placed at given position"
  
  input {
    int row { description = "Row to check" }
    int col { description = "Column to check" }
    int[] board { description = "Current board state (queen positions in previous rows)" }
  }
  
  stack {
    var $is_safe { value = true }
    var $prev_row { value = 0 }
    
    // Check against all previously placed queens
    while (($prev_row < $input.row) && $is_safe) {
      each {
        var $prev_col { value = $input.board[$prev_row] }
        
        // Check same column
        conditional {
          if ($prev_col == $input.col) {
            var $is_safe { value = false }
          }
        }
        
        // Check main diagonal (row - col is constant)
        conditional {
          if (($prev_row - $prev_col) == ($input.row - $input.col)) {
            var $is_safe { value = false }
          }
        }
        
        // Check anti-diagonal (row + col is constant)
        conditional {
          if (($prev_row + $prev_col) == ($input.row + $input.col)) {
            var $is_safe { value = false }
          }
        }
        
        var.update $prev_row { value = $prev_row + 1 }
      }
    }
  }
  
  response = $is_safe
}
