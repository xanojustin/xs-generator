function "detect_pattern" {
  description = "Detect if a pattern of length m is repeated k or more times consecutively in an array"
  input {
    int[] arr { description = "Array of positive integers to search" }
    int m { description = "Length of the pattern to detect" }
    int k { description = "Minimum number of consecutive repetitions" }
  }
  stack {
    // Edge case: if array is too small to contain k patterns of length m
    var $required_length { value = $input.m * $input.k }
    
    conditional {
      if (($input.arr|count) < $required_length) {
        return { value = false }
      }
    }
    
    // Calculate how many starting positions to check
    var $max_start { value = ($input.arr|count) - $required_length + 1 }
    var $found { value = false }
    
    // Try each possible starting position
    for ($max_start) {
      each as $start_idx {
        conditional {
          if ($found == true) {
            break
          }
        }
        
        // Get the pattern starting at this position
        var $pattern_start { value = $start_idx }
        var $is_match { value = true }
        
        // Check if pattern repeats k times consecutively
        for ($input.k - 1) {
          each as $rep_idx {
            conditional {
              if ($is_match == false) {
                break
              }
            }
            
            // Compare each element in the pattern
            var $pattern_offset { value = $rep_idx + 1 }
            
            for ($input.m) {
              each as $elem_idx {
                conditional {
                  if ($is_match == false) {
                    break
                  }
                }
                
                var $first_pos { value = $pattern_start + $elem_idx }
                var $compare_pos { value = $pattern_start + ($pattern_offset * $input.m) + $elem_idx }
                
                // Get elements for comparison using |get filter
                var $first_elem { value = $input.arr|get:$first_pos }
                var $compare_elem { value = $input.arr|get:$compare_pos }
                
                conditional {
                  if ($first_elem != $compare_elem) {
                    var.update $is_match { value = false }
                  }
                }
              }
            }
          }
        }
        
        conditional {
          if ($is_match == true) {
            var.update $found { value = true }
          }
        }
      }
    }
  }
  response = $found
}
