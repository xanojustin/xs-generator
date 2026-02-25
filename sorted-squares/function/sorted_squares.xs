// Sorted Squares - Classic coding exercise
// Given an integer array sorted in non-decreasing order,
// return an array of the squares of each number sorted in non-decreasing order
function "sorted_squares" {
  description = "Returns sorted squares of a sorted integer array"
  
  input {
    int[] nums { description = "Sorted array of integers (may contain negatives)" }
  }
  
  stack {
    // Handle empty array edge case
    var $n { value = $input.nums|count }
    
    conditional {
      if ($n == 0) {
        return { value = [] }
      }
    }
    
    // Initialize two pointers and result array
    var $left { value = 0 }
    var $right { value = $n - 1 }
    var $result { value = [] }
    var $result_index { value = $n - 1 }
    
    // Fill result array from the end (largest squares first)
    while ($left <= $right) {
      each {
        // Get values at both pointers
        var $left_val { value = $input.nums[$left] }
        var $right_val { value = $input.nums[$right] }
        
        // Calculate squares
        var $left_sq { value = $left_val * $left_val }
        var $right_sq { value = $right_val * $right_val }
        
        conditional {
          if ($left_sq > $right_sq) {
            // Left square is larger - place it and move left pointer
            var $result {
              value = $result|set:$result_index:$left_sq
            }
            var.update $left { value = $left + 1 }
          }
          else {
            // Right square is larger or equal - place it and move right pointer
            var $result {
              value = $result|set:$result_index:$right_sq
            }
            var.update $right { value = $right - 1 }
          }
        }
        
        var.update $result_index { value = $result_index - 1 }
      }
    }
  }
  
  response = $result
}
