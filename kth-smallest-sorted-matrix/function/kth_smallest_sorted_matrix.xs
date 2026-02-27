function "kth_smallest_sorted_matrix" {
  description = "Find the kth smallest element in a sorted n x n matrix where each row and column is sorted in ascending order. Uses binary search on the value range for O(n log(max-min)) time complexity."
  
  input {
    object matrix {
      description = "n x n matrix where each row and column is sorted in ascending order"
      schema {
        object[] rows {
          schema {
            int[] values
          }
        }
      }
    }
    int k {
      description = "The kth position to find (1-based index)"
    }
  }
  
  stack {
    // Validate inputs
    precondition ($input.matrix != null) {
      error_type = "inputerror"
      error = "Matrix cannot be null"
    }
    
    precondition ($input.k > 0) {
      error_type = "inputerror"
      error = "k must be positive"
    }
    
    // Get matrix dimensions and validate it's not empty
    var $rows { value = $input.matrix.rows }
    var $n { value = $rows|count }
    
    precondition ($n > 0) {
      error_type = "inputerror"
      error = "Matrix cannot be empty"
    }
    
    // Get first row to check columns
    var $first_row { value = $rows|get:0 }
    var $first_row_values { value = $first_row.values }
    var $m { value = $first_row_values|count }
    
    precondition ($m > 0) {
      error_type = "inputerror"
      error = "Matrix rows cannot be empty"
    }
    
    // Validate k is within bounds
    var $total_elements { value = $n * $m }
    precondition ($input.k <= $total_elements) {
      error_type = "inputerror"
      error = "k exceeds matrix size"
    }
    
    // Get min and max values for binary search range
    var $min_val { value = $first_row_values|get:0 }
    var $last_row { value = $rows|last }
    var $last_row_values { value = $last_row.values }
    var $max_val { value = $last_row_values|last }
    
    // Binary search on value range
    var $low { value = $min_val }
    var $high { value = $max_val }
    var $result { value = $min_val }
    
    while ($low <= $high) {
      each {
        // Calculate mid
        var $mid { value = ($low + $high) / 2 }
        
        // Count elements <= mid in the sorted matrix
        // Start from bottom-left corner and move
        var $count { value = 0 }
        var $row { value = $n - 1 }
        var $col { value = 0 }
        
        while ($row >= 0 && $col < $m) {
          each {
            var $current_row { value = $rows|get:$row }
            var $current_values { value = $current_row.values }
            var $current_val { value = $current_values|get:$col }
            
            conditional {
              if ($current_val <= $mid) {
                // All elements above in this column are also <= mid (since column is sorted)
                var $row_plus_one { value = $row + 1 }
                var $count { value = $count + $row_plus_one }
                var $col { value = $col + 1 }
              }
              else {
                var $row { value = $row - 1 }
              }
            }
          }
        }
        
        // Adjust binary search bounds
        conditional {
          if ($count < $input.k) {
            var $low { value = $mid + 1 }
          }
          else {
            var $result { value = $mid }
            var $high { value = $mid - 1 }
          }
        }
      }
    }
  }
  
  response = $result
}
