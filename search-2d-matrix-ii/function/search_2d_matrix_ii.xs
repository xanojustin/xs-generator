// Search a 2D Matrix II
// Write an efficient algorithm that searches for a target value in an m x n matrix.
// This matrix has the following properties:
// - Integers in each row are sorted in ascending from left to right.
// - Integers in each column are sorted in ascending from top to bottom.
// 
// Algorithm: Start from top-right corner, eliminate one row or column at a time
// Time Complexity: O(m + n), Space Complexity: O(1)
function "search_2d_matrix_ii" {
  description = "Search for a target value in a row and column sorted matrix"
  
  input {
    json matrix { description = "2D matrix where rows and columns are sorted ascending" }
    int target { description = "Value to search for" }
  }
  
  stack {
    // Get matrix dimensions
    var $rows { value = $input.matrix|count }
    
    // Handle empty matrix
    conditional {
      if ($rows == 0) {
        return { value = false }
      }
    }
    
    var $cols { value = $input.matrix[0]|count }
    
    // Handle empty rows
    conditional {
      if ($cols == 0) {
        return { value = false }
      }
    }
    
    // Start from top-right corner
    var $row { value = 0 }
    var $col { value = $cols - 1 }
    var $found { value = false }
    
    // Search while within bounds
    while ($row < $rows && $col >= 0) {
      each {
        var $current { value = $input.matrix[$row][$col] }
        
        conditional {
          if ($current == $input.target) {
            // Found the target
            var.update $found { value = true }
            return { value = $found }
          }
          elseif ($current > $input.target) {
            // Current is too large, move left
            var.update $col { value = $col - 1 }
          }
          else {
            // Current is too small, move down
            var.update $row { value = $row + 1 }
          }
        }
      }
    }
  }
  
  response = $found
}
