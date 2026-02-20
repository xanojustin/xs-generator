// Pascal's Triangle - Classic coding exercise
// Generates the first n rows of Pascal's Triangle
// Each number is the sum of the two numbers directly above it
function "pascals_triangle" {
  description = "Generates the first n rows of Pascal's Triangle"
  
  input {
    int rows { description = "Number of rows to generate (non-negative)" }
  }
  
  stack {
    // Handle edge case: 0 rows requested
    conditional {
      if (`$input.rows <= 0`) {
        return { value = [] }
      }
    }
    
    // Initialize the triangle with the first row
    var $triangle { value = [[1]] }
    var $row_index { value = 1 }
    
    // Build each subsequent row
    while (`$row_index < $input.rows`) {
      each {
        var $prev_row { value = $triangle|last }
        var $new_row { value = [1] }
        var $col_index { value = 0 }
        
        // Calculate middle elements (sum of two elements above)
        while (`$col_index < ($prev_row|count) - 1`) {
          each {
            var $left { value = $prev_row|get:($col_index|to_text) }
            var $right { value = $prev_row|get:(($col_index + 1)|to_text) }
            var $sum { value = $left + $right }
            var.update $new_row { value = $new_row|merge:[$sum] }
            var.update $col_index { value = $col_index + 1 }
          }
        }
        
        // Add the final 1 to complete the row
        var.update $new_row { value = $new_row|merge:[1] }
        
        // Append new row to triangle
        var.update $triangle { value = $triangle|merge:[$new_row] }
        var.update $row_index { value = $row_index + 1 }
      }
    }
  }
  
  response = $triangle
}
