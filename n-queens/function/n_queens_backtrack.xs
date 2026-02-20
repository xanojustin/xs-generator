// N-Queens Backtracking Helper
// Recursive helper function to place queens row by row
function "n_queens_backtrack" {
  description = "Backtracking helper for N-Queens - places queens row by row"
  
  input {
    int row { description = "Current row to place queen" }
    int n { description = "Board size" }
    int[] board { description = "Array where board[i] = column of queen in row i" }
  }
  
  stack {
    // Base case: all queens placed
    conditional {
      if ($input.row >= $input.n) {
        // Found a valid solution - return it wrapped in array
        var $solution { value = [$input.board] }
        return { value = $solution }
      }
    }
    
    var $all_solutions { value = [] }
    var $col { value = 0 }
    
    // Try placing queen in each column of current row
    while ($col < $input.n) {
      each {
        // Check if placing queen at (row, col) is safe
        function.run "n_queens_is_safe" {
          input = {
            row: $input.row
            col: $col
            board: $input.board
          }
        } as $is_safe
        
        conditional {
          if ($is_safe) {
            // Place queen and recurse
            var $new_board { value = $input.board|merge:[$col] }
            
            function.run "n_queens_backtrack" {
              input = {
                row: $input.row + 1
                n: $input.n
                board: $new_board
              }
            } as $sub_solutions
            
            // Merge sub-solutions into all_solutions
            foreach ($sub_solutions) {
              each as $sol {
                var $all_solutions { value = $all_solutions|merge:[$sol] }
              }
            }
          }
        }
        
        var.update $col { value = $col + 1 }
      }
    }
  }
  
  response = $all_solutions
}
