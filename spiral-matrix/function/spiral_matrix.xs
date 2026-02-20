// Spiral Matrix - Classic matrix traversal exercise
// Returns all elements of a 2D matrix in spiral order (clockwise from top-left)
function "spiral_matrix" {
  description = "Returns all elements of a matrix in spiral order (clockwise)"

  input {
    json matrix { description = "2D array of integers representing the matrix" }
  }

  stack {
    // Initialize result array
    var $result { value = [] }
    
    // Get matrix dimensions
    var $rows { value = $input.matrix|count }
    
    // Handle empty matrix edge case
    conditional {
      if ($rows == 0) {
        return { value = $result }
      }
    }
    
    var $cols { value = $input.matrix[0]|count }
    
    // Handle empty row edge case
    conditional {
      if ($cols == 0) {
        return { value = $result }
      }
    }
    
    // Define boundaries for spiral traversal
    var $top { value = 0 }
    var $bottom { value = $rows - 1 }
    var $left { value = 0 }
    var $right { value = $cols - 1 }
    
    // Continue while boundaries are valid
    while (($top <= $bottom) && ($left <= $right)) {
      each {
        // Traverse top row from left to right
        var $col { value = $left }
        while ($col <= $right) {
          each {
            array.push $result {
              value = $input.matrix[$top][$col]
            }
            math.add $col { value = 1 }
          }
        }
        math.add $top { value = 1 }
        
        // Traverse right column from top to bottom
        conditional {
          if ($top <= $bottom) {
            var $row { value = $top }
            while ($row <= $bottom) {
              each {
                array.push $result {
                  value = $input.matrix[$row][$right]
                }
                math.add $row { value = 1 }
              }
            }
            math.sub $right { value = 1 }
          }
        }
        
        // Traverse bottom row from right to left
        conditional {
          if (($top <= $bottom) && ($left <= $right)) {
            var $col2 { value = $right }
            while ($col2 >= $left) {
              each {
                array.push $result {
                  value = $input.matrix[$bottom][$col2]
                }
                math.sub $col2 { value = 1 }
              }
            }
            math.sub $bottom { value = 1 }
          }
        }
        
        // Traverse left column from bottom to top
        conditional {
          if (($top <= $bottom) && ($left <= $right)) {
            var $row2 { value = $bottom }
            while ($row2 >= $top) {
              each {
                array.push $result {
                  value = $input.matrix[$row2][$left]
                }
                math.sub $row2 { value = 1 }
              }
            }
            math.add $left { value = 1 }
          }
        }
      }
    }
  }

  response = $result
}
