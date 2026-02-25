// Helper to set a specific cell in visited grid
function "set-visited" {
  description = "Sets a specific cell in the visited grid to true/false"
  
  input {
    json visited
    int row
    int col
    bool value
    int rows
    int cols
  }
  
  stack {
    var $new_visited { value = [] }
    var $r { value = 0 }
    while ($r < $input.rows) {
      each {
        var $new_row { value = [] }
        var $c { value = 0 }
        while ($c < $input.cols) {
          each {
            conditional {
              if ($r == $input.row && $c == $input.col) {
                var $new_row { value = $new_row|merge:[$input.value] }
              }
              else {
                var $new_row { value = $new_row|merge:[$input.visited[$r][$c]] }
              }
            }
            var.update $c { value = $c + 1 }
          }
        }
        var $new_visited { value = $new_visited|merge:[$new_row] }
        var.update $r { value = $r + 1 }
      }
    }
    
    return { value = $new_visited }
  }
  
  response = $output
}
