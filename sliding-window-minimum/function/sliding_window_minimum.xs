function "sliding_window_minimum" {
  description = "Find the minimum value in every contiguous subarray (window) of size k"
  input {
    int[] nums { description = "Array of integers" }
    int k filters = min:1 { description = "Window size" }
  }
  stack {
    // Handle edge cases
    precondition (($input.nums|count) > 0) {
      error_type = "inputerror"
      error = "Input array cannot be empty"
    }
    
    precondition ($input.k <= ($input.nums|count)) {
      error_type = "inputerror"
      error = "Window size k cannot be larger than array length"
    }
    
    // Initialize variables
    var $n { value = ($input.nums|count) }
    var $result { value = [] }
    // Deque stores indices, maintains increasing order of values
    var $deque { value = [] }
    
    // Process first window
    for ($input.k) {
      each as $i {
        // Remove from back while current element is smaller
        // (they can't be minimum for any future window)
        var $continue_checking { value = true }
        
        while (($deque|count) > 0 && $continue_checking) {
          each {
            var $back_idx { value = $deque|last }
            var $back_val { value = $input.nums|get:$back_idx }
            var $curr_val { value = $input.nums|get:$i }
            
            conditional {
              if ($back_val >= $curr_val) {
                // Remove from back - pop the last element
                var $popped { value = $deque|pop }
              }
              else {
                var.update $continue_checking { value = false }
              }
            }
          }
        }
        
        // Add current index to back of deque
        var.update $deque { value = $deque|push:$i }
      }
    }
    
    // Add minimum of first window to result
    var $first_min_idx { value = $deque|first }
    var $first_min { value = $input.nums|get:$first_min_idx }
    var.update $result { value = $result|push:$first_min }
    
    // Process remaining windows
    var $start_idx { value = $input.k }
    
    while ($start_idx < $n) {
      each {
        // Remove indices that are out of the current window
        var $window_start { value = $start_idx - $input.k + 1 }
        
        // Check if front of deque is out of window
        conditional {
          if (($deque|count) > 0) {
            var $front_idx { value = $deque|first }
            conditional {
              if ($front_idx < $window_start) {
                var $shifted { value = $deque|shift }
              }
            }
          }
        }
        
        // Remove from back while current element is smaller
        var $continue_checking2 { value = true }
        
        while (($deque|count) > 0 && $continue_checking2) {
          each {
            var $back_idx2 { value = $deque|last }
            var $back_val2 { value = $input.nums|get:$back_idx2 }
            var $curr_val2 { value = $input.nums|get:$start_idx }
            
            conditional {
              if ($back_val2 >= $curr_val2) {
                var $popped2 { value = $deque|pop }
              }
              else {
                var.update $continue_checking2 { value = false }
              }
            }
          }
        }
        
        // Add current index to back of deque
        var.update $deque { value = $deque|push:$start_idx }
        
        // Add minimum of current window to result
        var $min_idx { value = $deque|first }
        var $min_val { value = $input.nums|get:$min_idx }
        var.update $result { value = $result|push:$min_val }
        
        // Increment index
        var.update $start_idx { value = $start_idx + 1 }
      }
    }
  }
  response = $result
}
