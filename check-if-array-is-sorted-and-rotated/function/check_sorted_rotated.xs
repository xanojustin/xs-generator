function "check_sorted_rotated" {
  description = "Check if an array was originally sorted in non-decreasing order and then rotated some number of times"
  input {
    int[] nums
  }
  stack {
    var $n { value = ($input.nums|count) }
    
    conditional {
      if ($n <= 1) {
        return { value = true }
      }
    }
    
    var $pivot_count { value = 0 }
    var $idx { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        var $next_idx { value = ($idx + 1) % $n }
        var $next_slice { value = $input.nums|slice:$next_idx:1 }
        var $next_val { value = $next_slice|first }
        
        conditional {
          if ($num > $next_val) {
            var.update $pivot_count { value = $pivot_count + 1 }
          }
        }
        
        var.update $idx { value = $idx + 1 }
      }
    }
    
    var $result { value = false }
    
    conditional {
      if ($pivot_count <= 1) {
        var.update $result { value = true }
      }
    }
  }
  response = $result
}
