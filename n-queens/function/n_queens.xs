// N-Queens - Classic backtracking problem
// Finds all distinct solutions to the n-queens puzzle
// Solutions are returned as arrays of board strings where 'Q' is a queen and '.' is empty
function "n_queens" {
  description = "Solves the N-Queens problem using backtracking"
  
  input {
    int n { description = "Board size (n x n) and number of queens" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if ($input.n <= 0) {
        return { value = [] }
      }
      elseif ($input.n == 1) {
        return { value = [["Q"]] }
      }
    }
    
    // Initialize board representation
    // board[i] = column position of queen in row i
    var $solutions { value = [] }
    var $current_board { value = [] }
    
    // Start backtracking from row 0
    function.run "n_queens_backtrack" {
      input = {
        row: 0
        n: $input.n
        board: $current_board
      }
    } as $backtrack_result
    
    // Convert board representations to string format
    var $formatted_solutions { value = [] }
    foreach ($backtrack_result) {
      each as $solution {
        var $board_strings { value = [] }
        var $row_idx { value = 0 }
        while ($row_idx < $input.n) {
          each {
            var $col { value = $solution[$row_idx] }
            var $row_string { value = "" }
            var $col_idx { value = 0 }
            while ($col_idx < $input.n) {
              each {
                conditional {
                  if ($col_idx == $col) {
                    var $row_string { value = $row_string ~ "Q" }
                  }
                  else {
                    var $row_string { value = $row_string ~ "." }
                  }
                }
                var.update $col_idx { value = $col_idx + 1 }
              }
            }
            var $board_strings { value = $board_strings|merge:[$row_string] }
            var.update $row_idx { value = $row_idx + 1 }
          }
        }
        var $formatted_solutions { value = $formatted_solutions|merge:[$board_strings] }
      }
    }
  }
  
  response = $formatted_solutions
}
