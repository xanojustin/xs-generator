// Diagonal Traverse - Traverse a matrix diagonally in alternating directions
// Given an m x n matrix, return all elements in diagonal order
function "diagonal_traverse" {
  description = "Traverses a matrix diagonally in alternating directions"
  
  input {
    json matrix { description = "2D array of integers to traverse" }
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
    
    var $row { value = 0 }
    var $col { value = 0 }
    var $going_up { value = true }
    
    // Process all elements
    while (($row < $rows) && ($col < $cols)) {
      each {
        // Add current element to result
        array.push $result {
          value = $input.matrix[$row][$col]
        }
        
        // Determine next position based on direction
        conditional {
          if ($going_up) {
            // Going up-right
            conditional {
              if (($col == ($cols - 1)) && ($row == 0)) {
                // Hit top-right corner, go right
                math.add $col { value = 1 }
                var $going_up { value = false }
              }
              elseif ($col == ($cols - 1)) {
                // Hit right boundary, go down
                math.add $row { value = 1 }
                var $going_up { value = false }
              }
              elseif ($row == 0) {
                // Hit top boundary, go right
                math.add $col { value = 1 }
                var $going_up { value = false }
              }
              else {
                // Normal up-right movement
                math.sub $row { value = 1 }
                math.add $col { value = 1 }
              }
            }
          }
          else {
            // Going down-left
            conditional {
              if (($row == ($rows - 1)) && ($col == 0)) {
                // Hit bottom-left corner, go right
                math.add $col { value = 1 }
                var $going_up { value = true }
              }
              elseif ($row == ($rows - 1)) {
                // Hit bottom boundary, go right
                math.add $col { value = 1 }
                var $going_up { value = true }
              }
              elseif ($col == 0) {
                // Hit left boundary, go down
                math.add $row { value = 1 }
                var $going_up { value = true }
              }
              else {
                // Normal down-left movement
                math.add $row { value = 1 }
                math.sub $col { value = 1 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $result
}
