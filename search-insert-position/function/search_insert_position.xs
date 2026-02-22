function "search_insert_position" {
  description = "Find target index in sorted array or return insertion position using binary search"
  
  input {
    int[] nums
    int target
  }
  
  stack {
    // Initialize binary search bounds
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }
    var $result { value = ($input.nums|count) }
    
    // Binary search for target or insertion position
    while ($left <= $right) {
      each {
        // Calculate middle index (avoid overflow)
        var $mid { value = $left + (($right - $left) / 2) }
        
        // Get middle element
        var $mid_value { value = $input.nums[$mid] }
        
        conditional {
          if ($mid_value == $input.target) {
            // Target found - return index immediately
            var.update $result { value = $mid }
            return { value = $result }
          }
          elseif ($mid_value < $input.target) {
            // Target is in right half
            var.update $left { value = $mid + 1 }
          }
          else {
            // Target is in left half - update result as potential insertion point
            var.update $result { value = $mid }
            var.update $right { value = $mid - 1 }
          }
        }
      }
    }
  }
  
  response = $result
}
