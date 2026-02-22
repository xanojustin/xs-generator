// Helper function to find the next empty cell (marked with 0)
function "find_empty" {
  description = "Finds the next empty cell in the Sudoku board"
  
  input {
    json board { description = "9x9 Sudoku board with 0 for empty cells" }
  }
  
  stack {
    var $result { value = { found: false } }
    var $row { value = 0 }
    var $found { value = false }
    
    while ($row < 9 && !$found) {
      each {
        var $col { value = 0 }
        while ($col < 9 && !$found) {
          each {
            conditional {
              if ($input.board[$row][$col] == 0) {
                var $result { 
                  value = {
                    found: true,
                    row: $row,
                    col: $col
                  }
                }
                var $found { value = true }
              }
            }
            var.update $col { value = $col + 1 }
          }
        }
        var.update $row { value = $row + 1 }
      }
    }
  }
  
  response = $result
}