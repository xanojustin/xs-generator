function "max-diff" {
  description = "Find the maximum difference between two elements where the larger element comes after the smaller one"
  
  input {
    int[] nums { description = "Array of integers to analyze" }
  }
  
  stack {
    // Handle edge case: array needs at least 2 elements
    precondition (($input.nums|count) >= 2) {
      error_type = "inputerror"
      error = "Array must contain at least 2 elements"
    }
    
    // Initialize min_so_far to first element
    var $min_so_far { value = $input.nums|first }
    
    // Initialize max_diff to -1 (no valid pair found yet)
    var $max_diff { value = -1 }
    
    // Iterate through array starting from second element
    foreach ($input.nums) {
      each as $num {
        conditional {
          // Skip the first element (index 0) since we start from second
          if ($index > 0) {
            // Check if current element can form a valid increasing pair
            conditional {
              if ($num > $min_so_far) {
                // Calculate potential difference
                var $diff { value = $num - $min_so_far }
                
                // Update max_diff if this difference is larger
                conditional {
                  if ($diff > $max_diff) {
                    var.update $max_diff { value = $diff }
                  }
                }
              }
            }
            
            // Update min_so_far for future iterations
            conditional {
              if ($num < $min_so_far) {
                var.update $min_so_far { value = $num }
              }
            }
          }
        }
      }
    }
  }
  
  response = $max_diff
}
