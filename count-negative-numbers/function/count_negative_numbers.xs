// Count Negative Numbers in a Sorted Matrix
// Given a m x n matrix sorted in non-increasing order both row-wise and column-wise,
// return the count of negative numbers in the matrix.
function "count_negative_numbers" {
  description = "Counts negative numbers in a matrix sorted in non-increasing order"
  
  input {
    json grid { description = "2D matrix sorted in non-increasing order" }
  }
  
  stack {
    var $count { value = 0 }
    var $row_count { value = $input.grid|count }
    
    // Handle empty grid case
    conditional {
      if (`$row_count == 0`) {
        var $count { value = 0 }
      }
      else {
        var $col_count { value = $input.grid[0]|count }
        var $row { value = 0 }
        
        // Iterate through each row
        while (`$row < $row_count`) {
          each {
            var $col { value = 0 }
            
            // For each row, iterate through columns until we find a negative
            // Since rows are sorted in non-increasing order, once we find
            // a negative, all remaining elements in that row are negative
            while (`$col < $col_count`) {
              each {
                conditional {
                  if (`$input.grid[$row][$col] < 0`) {
                    // All remaining elements in this row are negative
                    var $remaining { value = `$col_count - $col` }
                    var $count { value = `$count + $remaining` }
                    // Break out of column loop for this row by setting col to col_count
                    var $col { value = $col_count }
                  }
                  else {
                    var.update $col { value = `$col + 1` }
                  }
                }
              }
            }
            
            var.update $row { value = `$row + 1` }
          }
        }
      }
    }
  }
  
  response = $count
}
