// Maximal Rectangle - Classic coding exercise
// Given a binary matrix filled with 0s and 1s, find the largest rectangle
// containing only 1s and return its area.
function "maximal_rectangle" {
  description = "Finds the largest rectangle of 1s in a binary matrix"
  
  input {
    json matrix { description = "Binary matrix containing 0s and 1s" }
  }
  
  stack {
    // Handle empty matrix
    var $matrix_count { value = ($input.matrix|count) }
    conditional {
      if ($matrix_count == 0) {
        return { value = 0 }
      }
    }
    
    var $rows { value = ($input.matrix|count) }
    var $cols { value = ($input.matrix[0]|count) }
    
    // Handle empty rows
    conditional {
      if ($cols == 0) {
        return { value = 0 }
      }
    }
    
    // heights array tracks consecutive 1s ending at each column for current row
    var $heights { value = [] }
    var $j_init { value = 0 }
    while ($j_init < $cols) {
      each {
        array.push $heights { value = 0 }
        var.update $j_init { value = $j_init + 1 }
      }
    }
    
    var $max_area { value = 0 }
    var $row_idx { value = 0 }
    
    while ($row_idx < $rows) {
      each {
        // Update heights based on current row
        var $col_idx { value = 0 }
        while ($col_idx < $cols) {
          each {
            conditional {
              if ($input.matrix[$row_idx][$col_idx] == 1) {
                // Increment height if current cell is 1
                var.update $heights[$col_idx] { value = $heights[$col_idx] + 1 }
              }
              else {
                // Reset to 0 if current cell is 0
                var.update $heights[$col_idx] { value = 0 }
              }
            }
            var.update $col_idx { value = $col_idx + 1 }
          }
        }
        
        // Find largest rectangle in histogram for current heights
        // Using stack-based approach
        var $stack { value = [] }
        var $i { value = 0 }
        
        while ($i <= $cols) {
          each {
            // Current height (0 if we've reached end)
            var $curr_height { value = 0 }
            conditional {
              if ($i < $cols) {
                var.update $curr_height { value = $heights[$i] }
              }
            }
            
            // Pop from stack while current height is smaller than stack top
            var $stack_count { value = ($stack|count) }
            var $continue_popping { value = true }
            
            while ($continue_popping && $stack_count > 0) {
              each {
                var $stack_top_idx { value = $stack_count - 1 }
                var $top_idx { value = $stack[$stack_top_idx] }
                
                conditional {
                  if ($heights[$top_idx] > $curr_height) {
                    // Pop from stack
                    array.pop $stack as $top
                    var $height { value = $heights[$top] }
                    
                    // Calculate width
                    var $new_stack_count { value = ($stack|count) }
                    var $width { value = 0 }
                    conditional {
                      if ($new_stack_count == 0) {
                        var.update $width { value = $i }
                      }
                      else {
                        var $new_top { value = $stack[$new_stack_count - 1] }
                        var.update $width { value = $i - $new_top - 1 }
                      }
                    }
                    
                    // Calculate area
                    var $area { value = $height * $width }
                    
                    // Update max area
                    conditional {
                      if ($area > $max_area) {
                        var.update $max_area { value = $area }
                      }
                    }
                    
                    var.update $stack_count { value = ($stack|count) }
                  }
                  else {
                    var.update $continue_popping { value = false }
                  }
                }
              }
            }
            
            // Push current index to stack
            conditional {
              if ($i < $cols) {
                array.push $stack { value = $i }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var.update $row_idx { value = $row_idx + 1 }
      }
    }
  }
  
  response = $max_area
}
