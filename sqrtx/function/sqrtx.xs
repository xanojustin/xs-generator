function "sqrtx" {
  description = "Compute and return the square root of x, rounded down to the nearest integer"
  input {
    int x filters=min:0
  }
  stack {
    // Handle edge cases: 0 and 1
    conditional {
      if ($input.x < 2) {
        return { value = $input.x }
      }
    }
    
    // Binary search for square root
    var $left { value = 1 }
    var $right { value = $input.x / 2 }
    var $result { value = 0 }
    
    while ($left <= $right) {
      each {
        var $mid { value = ($left + $right) / 2 }
        var $squared { value = $mid * $mid }
        
        conditional {
          if ($squared == $input.x) {
            // Perfect square found
            return { value = $mid }
          }
          elseif ($squared < $input.x) {
            // Mid might be the answer, search right half
            var $result { value = $mid }
            var $left { value = $mid + 1 }
          }
          else {
            // Squared is too large, search left half
            var $right { value = $mid - 1 }
          }
        }
      }
    }
  }
  response = $result
}