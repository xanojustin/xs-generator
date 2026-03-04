function "find_first_last_position" {
  description = "Find the first and last position of a target element in a sorted array"
  input {
    int[] nums
    int target
  }
  stack {
    // Edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = [-1, -1] }
      }
    }
    
    // Helper function to find first occurrence using binary search
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }
    var $first { value = -1 }
    
    while ($left <= $right) {
      each {
        var $mid { value = ($left + $right) / 2 }
        var $mid_val { value = $input.nums|get:$mid }
        
        conditional {
          if ($mid_val == $input.target) {
            var.update $first { value = $mid }
            var.update $right { value = $mid - 1 }
          }
          elseif ($mid_val < $input.target) {
            var.update $left { value = $mid + 1 }
          }
          else {
            var.update $right { value = $mid - 1 }
          }
        }
      }
    }
    
    // If first not found, target doesn't exist
    conditional {
      if ($first == -1) {
        return { value = [-1, -1] }
      }
    }
    
    // Find last occurrence using binary search
    var.update $left { value = 0 }
    var.update $right { value = ($input.nums|count) - 1 }
    var $last { value = -1 }
    
    while ($left <= $right) {
      each {
        var $mid { value = ($left + $right) / 2 }
        var $mid_val { value = $input.nums|get:$mid }
        
        conditional {
          if ($mid_val == $input.target) {
            var.update $last { value = $mid }
            var.update $left { value = $mid + 1 }
          }
          elseif ($mid_val < $input.target) {
            var.update $left { value = $mid + 1 }
          }
          else {
            var.update $right { value = $mid - 1 }
          }
        }
      }
    }
    
    var $result { value = [$first, $last] }
  }
  response = $result
}
