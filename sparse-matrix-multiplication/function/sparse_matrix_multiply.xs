function "sparse_matrix_multiply" {
  description = "Multiplies two sparse matrices and returns the result as a sparse matrix"
  
  input {
    object[] matrix_a {
      description = "First sparse matrix as array of {row, col, value} objects"
    }
    object[] matrix_b {
      description = "Second sparse matrix as array of {row, col, value} objects"
    }
    int a_rows {
      description = "Number of rows in matrix A"
    }
    int a_cols {
      description = "Number of columns in matrix A (must equal b_rows)"
    }
    int b_cols {
      description = "Number of columns in matrix B"
    }
  }
  
  stack {
    // Precondition: Matrix A columns must equal Matrix B rows
    precondition ($input.a_cols == ($input.matrix_b|first).row|to_int) {
      error_type = "inputerror"
      error = "Matrix A columns must equal Matrix B rows for multiplication"
    }
    
    // Build a lookup for matrix B organized by row for efficient access
    // This lets us quickly find all elements in B with a specific row
    var $b_by_row { value = {} }
    foreach ($input.matrix_b) {
      each as $b_elem {
        var $b_row { value = $b_elem.row }
        var $b_col { value = $b_elem.col }
        var $b_val { value = $b_elem.value }
        
        // Check if we already have this row key
        conditional {
          if (($b_by_row|has:($b_row|to_text)) == false) {
            var $b_by_row { 
              value = ($b_by_row|set:($b_row|to_text):[]) 
            }
          }
        }
        
        // Get the array for this row and append the element
        var $row_arr { value = $b_by_row|get:($b_row|to_text) }
        var $new_row_arr { value = $row_arr|merge:[{ col: $b_col, value: $b_val }] }
        var $b_by_row {
          value = ($b_by_row|set:($b_row|to_text):$new_row_arr)
        }
      }
    }
    
    // Result matrix stored as { "row,col": value } for easy aggregation
    var $result_map { value = {} }
    
    // For each non-zero element in A
    foreach ($input.matrix_a) {
      each as $a_elem {
        var $a_row { value = $a_elem.row }
        var $a_col { value = $a_elem.col }
        var $a_val { value = $a_elem.value }
        
        // Find all elements in B with row = a_col (since A's column index becomes B's row index)
        var $b_row_key { value = $a_col|to_text }
        
        conditional {
          if (($b_by_row|has:$b_row_key) == true) {
            var $b_elements { value = $b_by_row|get:$b_row_key }
            
            // Multiply A's element with each matching B element
            foreach ($b_elements) {
              each as $b_elem {
                var $result_row { value = $a_row }
                var $result_col { value = $b_elem.col }
                var $product { value = $a_val * $b_elem.value }
                
                // Create key for result cell
                var $cell_key { value = ($result_row|to_text) ~ "," ~ ($result_col|to_text) }
                
                // Accumulate into result
                conditional {
                  if (($result_map|has:$cell_key) == true) {
                    var $existing_val { value = $result_map|get:$cell_key }
                    var $new_val { value = $existing_val + $product }
                    var $result_map {
                      value = ($result_map|set:$cell_key:$new_val)
                    }
                  }
                  else {
                    var $result_map {
                      value = ($result_map|set:$cell_key:$product)
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Convert result map to sparse matrix format (array of {row, col, value})
    // Filter out zero values that may have resulted from cancellation
    var $result_sparse { value = [] }
    
    // Iterate through all possible result cells
    // We need to extract keys from result_map and process them
    // Since we can't directly iterate object keys, we'll use the fact that
    // we know the dimensions
    
    for ($input.a_rows) {
      each as $r_idx {
        var $current_row { value = $r_idx + 1 }
        
        for ($input.b_cols) {
          each as $c_idx {
            var $current_col { value = $c_idx + 1 }
            var $check_key { value = ($current_row|to_text) ~ "," ~ ($current_col|to_text) }
            
            conditional {
              if (($result_map|has:$check_key) == true) {
                var $cell_value { value = $result_map|get:$check_key }
                
                // Only include non-zero values
                conditional {
                  if ($cell_value != 0) {
                    var $new_elem { 
                      value = { row: $current_row, col: $current_col, value: $cell_value }
                    }
                    var $result_sparse {
                      value = $result_sparse|merge:[$new_elem]
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Sort result by row, then by column
    var $sorted_result {
      value = $result_sparse|sort:$$.row
    }
    
    // Secondary sort by column within each row
    // Since XanoScript doesn't have multi-level sort, we'll build row by row
    var $final_result { value = [] }
    
    for ($input.a_rows) {
      each as $sort_row_idx {
        var $target_row { value = $sort_row_idx + 1 }
        
        // Filter elements for this row
        var $row_elements {
          value = $sorted_result|filter:$$.row == $target_row
        }
        
        // Sort by column
        var $sorted_row_elements {
          value = $row_elements|sort:$$.col
        }
        
        // Add to final result
        var $final_result {
          value = $final_result|merge:$sorted_row_elements
        }
      }
    }
  }
  
  response = $final_result
}
