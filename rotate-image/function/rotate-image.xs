function "rotate_image" {
  description = "Rotate an n x n matrix 90 degrees clockwise in-place"
  
  input {
    json matrix { description = "2D array representing n x n matrix" }
  }
  
  stack {
    // Get matrix dimensions
    var $n { value = ($input.matrix|count) }
    
    // Handle edge cases: empty matrix or single element
    conditional {
      if ($n <= 1) {
        return { value = $input.matrix }
      }
    }
    
    // Make a copy of the matrix to work with
    var $result { value = $input.matrix }
    
    // Perform rotation layer by layer
    // For each layer from outside to inside
    var $layer { value = 0 }
    while ($layer < ($n / 2)) {
      each {
        var $first { value = $layer }
        var $last { value = $n - 1 - $layer }
        
        // For each element in the current layer's top row
        var $i { value = $first }
        while ($i < $last) {
          each {
            var $offset { value = $i - $first }
            
            // Save top-left element
            var $top { value = $result[$first][$i] }
            
            // Move bottom-left to top-left
            var.update $result {
              value = $result|set:$first:($result|get:$first|set:$i:$result[($last - $offset)][$first])
            }
            
            // Move bottom-right to bottom-left
            var.update $result {
              value = $result|set:($last - $offset):($result|get:($last - $offset)|set:$first:$result[$last][($last - $offset)])
            }
            
            // Move top-right to bottom-right
            var.update $result {
              value = $result|set:$last:($result|get:$last|set:($last - $offset):$result[$i][$last])
            }
            
            // Move saved top-left to top-right
            var.update $result {
              value = $result|set:$i:($result|get:$i|set:$last:$top)
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var.update $layer { value = $layer + 1 }
      }
    }
  }
  
  response = $result
}
