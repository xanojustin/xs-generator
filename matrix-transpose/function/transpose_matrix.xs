function "transpose_matrix" {
  description = "Transposes a 2D matrix (converts rows to columns and vice versa)"
  input {
    json matrix
  }
  stack {
    // Get dimensions of the input matrix
    var $rows { value = $input.matrix|count }
    var $cols { value = ($input.matrix|first)|count }
    
    // Initialize empty result matrix (will have swapped dimensions)
    var $result { value = [] }
    
    // Iterate through each column of original (becomes rows in result)
    var $col_idx { value = 0 }
    while ($col_idx < $cols) {
      each {
        // Create a new row for the transposed matrix
        var $new_row { value = [] }
        
        // Iterate through each row of original (becomes columns in result)
        var $row_idx { value = 0 }
        while ($row_idx < $rows) {
          each {
            // Get the value from original matrix at [row_idx][col_idx]
            var $original_row { value = $input.matrix[$row_idx] }
            var $value { value = $original_row[$col_idx] }
            
            // Append to new row
            var $new_row { value = $new_row ~ [$value] }
            
            // Increment row index
            var.update $row_idx { value = $row_idx + 1 }
          }
        }
        
        // Append the new row to result
        var $result { value = $result ~ [$new_row] }
        
        // Increment column index
        var.update $col_idx { value = $col_idx + 1 }
      }
    }
  }
  response = $result
}
