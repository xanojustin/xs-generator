// Set Matrix Zeroes - Classic matrix manipulation exercise
// Given an m x n matrix, if an element is 0, set its entire row and column to 0.
function "set_matrix_zeroes" {
  description = "Sets entire rows and columns to 0 where any element is 0"

  input {
    json matrix { description = "2D array of integers representing the matrix" }
  }

  stack {
    // Get dimensions
    var $rows { value = $input.matrix|count }
    var $cols { value = 0 }
    
    conditional {
      if ($rows > 0) {
        var $cols { value = $input.matrix[0]|count }
      }
    }

    // Track which rows and columns need to be zeroed
    var $zero_rows { value = [] }
    var $zero_cols { value = [] }

    // First pass: identify rows and columns containing zeros
    var $i { value = 0 }
    while ($i < $rows) {
      each {
        var $j { value = 0 }
        while ($j < $cols) {
          each {
            conditional {
              if ($input.matrix[$i][$j] == 0) {
                // Mark this row for zeroing
                array.push $zero_rows { value = $i }
                // Mark this column for zeroing
                array.push $zero_cols { value = $j }
              }
            }
            math.add $j { value = 1 }
          }
        }
        math.add $i { value = 1 }
      }
    }

    // Build the result matrix
    var $result { value = [] }
    
    var $r { value = 0 }
    while ($r < $rows) {
      each {
        var $new_row { value = [] }
        
        var $c { value = 0 }
        while ($c < $cols) {
          each {
            // Check if current row or column should be zero
            var $is_zero_row { value = false }
            var $is_zero_col { value = false }
            
            // Check if row r is in zero_rows
            var $idx { value = 0 }
            while ($idx < $zero_rows|count) {
              each {
                conditional {
                  if ($zero_rows[$idx] == $r) {
                    var $is_zero_row { value = true }
                  }
                }
                math.add $idx { value = 1 }
              }
            }
            
            // Check if column c is in zero_cols
            var $idx2 { value = 0 }
            while ($idx2 < $zero_cols|count) {
              each {
                conditional {
                  if ($zero_cols[$idx2] == $c) {
                    var $is_zero_col { value = true }
                  }
                }
                math.add $idx2 { value = 1 }
              }
            }
            
            conditional {
              if ($is_zero_row || $is_zero_col) {
                array.push $new_row { value = 0 }
              }
              else {
                array.push $new_row { value = $input.matrix[$r][$c] }
              }
            }
            
            math.add $c { value = 1 }
          }
        }
        
        array.push $result { value = $new_row }
        math.add $r { value = 1 }
      }
    }
  }

  response = $result
}
