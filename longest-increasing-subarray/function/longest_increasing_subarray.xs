// Longest Increasing Subarray
// Finds the length of the longest strictly increasing contiguous subarray
function "longest_increasing_subarray" {
  description = "Finds the length of the longest strictly increasing contiguous subarray"
  
  input {
    int[] nums { description = "Array of integers to analyze" }
  }
  
  stack {
    // Handle empty array edge case
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Handle single element edge case
    conditional {
      if (($input.nums|count) == 1) {
        return { value = 1 }
      }
    }
    
    var $max_length { value = 1 }
    var $current_length { value = 1 }
    var $i { value = 1 }
    
    while ($i < ($input.nums|count)) {
      each {
        conditional {
          // Check if current element is greater than previous (strictly increasing)
          if ($input.nums[$i] > $input.nums[$i - 1]) {
            var.update $current_length { value = $current_length + 1 }
            
            // Update max if current streak is longer
            conditional {
              if ($current_length > $max_length) {
                var.update $max_length { value = $current_length }
              }
            }
          }
          else {
            // Reset current streak
            var.update $current_length { value = 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $max_length
}
