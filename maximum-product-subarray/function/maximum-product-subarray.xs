// Maximum Product Subarray
// Finds the contiguous subarray with the largest product
function "maximum_product_subarray" {
  description = "Finds the maximum product of any contiguous subarray"
  
  input {
    int[] nums { description = "Array of integers (can contain positive, negative, and zero)" }
  }
  
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Handle single element
    conditional {
      if (($input.nums|count) == 1) {
        return { value = $input.nums|first }
      }
    }
    
    // Initialize: track both max and min ending at current position
    // (min can become max when multiplied by negative)
    var $max_ending_here { value = $input.nums|first }
    var $min_ending_here { value = $input.nums|first }
    var $max_global { value = $input.nums|first }
    var $i { value = 1 }
    
    // Iterate through array starting from second element
    while ($i < ($input.nums|count)) {
      each {
        // Get current number
        var $current { value = $input.nums[$i] }
        
        // Store current max before updating (needed for min calculation)
        var $prev_max { value = $max_ending_here }
        
        // Calculate candidates for new max
        // Option 1: Start fresh from current number
        // Option 2: Extend previous max subarray
        // Option 3: Extend previous min subarray (if current is negative)
        conditional {
          if ($current > 0) {
            // For positive current: max extends from max, min extends from min
            conditional {
              if (($max_ending_here * $current) > $current) {
                var $max_ending_here { value = $max_ending_here * $current }
              }
              else {
                var $max_ending_here { value = $current }
              }
            }
            conditional {
              if (($min_ending_here * $current) < $current) {
                var $min_ending_here { value = $min_ending_here * $current }
              }
              else {
                var $min_ending_here { value = $current }
              }
            }
          }
          else {
            // For negative or zero: max comes from min, min comes from max
            conditional {
              if (($min_ending_here * $current) > $current) {
                var $max_ending_here { value = $min_ending_here * $current }
              }
              else {
                var $max_ending_here { value = $current }
              }
            }
            conditional {
              if (($prev_max * $current) < $current) {
                var $min_ending_here { value = $prev_max * $current }
              }
              else {
                var $min_ending_here { value = $current }
              }
            }
          }
        }
        
        // Update global maximum
        conditional {
          if ($max_ending_here > $max_global) {
            var $max_global { value = $max_ending_here }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $max_global
}
