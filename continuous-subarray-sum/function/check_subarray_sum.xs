function "check_subarray_sum" {
  description = "Check if array has a continuous subarray of size at least 2 with sum divisible by k"
  input {
    int[] nums
    int k
  }
  stack {
    // Handle edge case: array needs at least 2 elements
    precondition (($input.nums|count) >= 2) {
      error_type = "inputerror"
      error = "Array must contain at least 2 elements"
    }

    // Handle k = 0 case - need to find subarray with sum = 0
    conditional {
      if ($input.k == 0) {
        // Look for any two consecutive zeros
        var $found { value = false }
        var $i { value = 0 }
        while (($i < (($input.nums|count) - 1)) && !$found) {
          each {
            var $current { value = $input.nums[$i] }
            var $next { value = $input.nums[$i + 1] }
            conditional {
              if (($current == 0) && ($next == 0)) {
                var.update $found { value = true }
              }
            }
            var.update $i { value = $i + 1 }
          }
        }
        var $result { value = { has_subarray: $found } }
      }
      else {
        // Use prefix sum + modulo trick
        // Map from modulo value to earliest index where we saw it
        var $mod_map { value = { "0": -1 } }
        var $prefix_sum { value = 0 }
        var $found { value = false }
        var $i { value = 0 }

        while (($i < ($input.nums|count)) && !$found) {
          each {
            // Add current number to prefix sum
            var.update $prefix_sum { value = $prefix_sum + $input.nums[$i] }
            
            // Calculate modulo (handle negative by adding k then mod again)
            var $mod_val { value = $prefix_sum % $input.k }
            conditional {
              if ($mod_val < 0) {
                var.update $mod_val { value = $mod_val + $input.k }
              }
            }
            
            // Check if we've seen this modulo before
            var $mod_key { value = $mod_val|to_text }
            var $mod_exists { value = ($mod_map|get:$mod_key) != null }
            
            conditional {
              if ($mod_exists) {
                // Get the previous index
                var $prev_idx { value = $mod_map|get:$mod_key }
                // If subarray length >= 2, we found it
                conditional {
                  if (($i - $prev_idx) >= 2) {
                    var.update $found { value = true }
                  }
                }
              }
              else {
                // Store first occurrence of this modulo
                var.update $mod_map { value = $mod_map|set:$mod_key:$i }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var $result { value = { has_subarray: $found } }
      }
    }
  }
  response = $result
}
