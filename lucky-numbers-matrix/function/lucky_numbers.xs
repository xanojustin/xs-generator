function "lucky_numbers" {
  description = "Find all lucky numbers in a matrix. A lucky number is the minimum in its row and maximum in its column."
  input {
    object matrix {
      description = "2D array of distinct integers"
      schema {
        json rows
      }
    }
  }
  stack {
    // Handle empty matrix case
    var $rows_count {
      value = ($input.matrix.rows)|count
    }
    
    conditional {
      if ($rows_count == 0) {
        return { value = [] }
      }
    }
    
    // Get number of columns from first row
    var $first_row {
      value = ($input.matrix.rows)|first
    }
    var $cols_count {
      value = $first_row|count
    }
    
    conditional {
      if ($cols_count == 0) {
        return { value = [] }
      }
    }
    
    // Find minimum of each row
    var $row_mins { value = [] }
    var $row_idx { value = 0 }
    
    while ($row_idx < $rows_count) {
      each {
        // Get current row
        var $current_row {
          value = ($input.matrix.rows)|get:$row_idx
        }
        
        // Find min in this row
        var $row_min {
          value = $current_row|first
        }
        var $col_idx_for_min { value = 0 }
        
        while ($col_idx_for_min < $cols_count) {
          each {
            var $current_val {
              value = $current_row|get:$col_idx_for_min
            }
            conditional {
              if ($current_val < $row_min) {
                var.update $row_min { value = $current_val }
              }
            }
            var.update $col_idx_for_min { value = $col_idx_for_min + 1 }
          }
        }
        
        // Store min for this row
        var.update $row_mins {
          value = $row_mins|append:$row_min
        }
        
        var.update $row_idx { value = $row_idx + 1 }
      }
    }
    
    // Find maximum of each column
    var $col_maxes { value = [] }
    var $col_idx { value = 0 }
    
    while ($col_idx < $cols_count) {
      each {
        // Get first value in this column
        var $first_row_for_col {
          value = ($input.matrix.rows)|first
        }
        var $col_max {
          value = $first_row_for_col|get:$col_idx
        }
        
        var $row_idx_for_max { value = 0 }
        while ($row_idx_for_max < $rows_count) {
          each {
            var $row_for_max {
              value = ($input.matrix.rows)|get:$row_idx_for_max
            }
            var $val_for_max {
              value = $row_for_max|get:$col_idx
            }
            conditional {
              if ($val_for_max > $col_max) {
                var.update $col_max { value = $val_for_max }
              }
            }
            var.update $row_idx_for_max { value = $row_idx_for_max + 1 }
          }
        }
        
        // Store max for this column
        var.update $col_maxes {
          value = $col_maxes|append:$col_max
        }
        
        var.update $col_idx { value = $col_idx + 1 }
      }
    }
    
    // Find lucky numbers (elements that are both row min and column max)
    var $lucky_numbers { value = [] }
    var $check_row { value = 0 }
    
    while ($check_row < $rows_count) {
      each {
        var $row_for_check {
          value = ($input.matrix.rows)|get:$check_row
        }
        var $row_min_val {
          value = $row_mins|get:$check_row
        }
        
        var $check_col { value = 0 }
        while ($check_col < $cols_count) {
          each {
            var $val {
              value = $row_for_check|get:$check_col
            }
            var $col_max_val {
              value = $col_maxes|get:$check_col
            }
            
            // Check if this element is min in row and max in column
            conditional {
              if ($val == $row_min_val && $val == $col_max_val) {
                var.update $lucky_numbers {
                  value = $lucky_numbers|append:$val
                }
              }
            }
            
            var.update $check_col { value = $check_col + 1 }
          }
        }
        
        var.update $check_row { value = $check_row + 1 }
      }
    }
  }
  response = $lucky_numbers
}
