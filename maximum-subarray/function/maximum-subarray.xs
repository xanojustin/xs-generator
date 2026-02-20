// Maximum Subarray - Kadane's Algorithm
// Finds the contiguous subarray with the largest sum
function "maximum_subarray" {
  description = "Finds the maximum sum of any contiguous subarray using Kadane's algorithm"
  
  input {
    int[] nums { description = "Array of integers (can contain positive and negative numbers)" }
  }
  
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize Kadane's algorithm variables
    var $max_current { value = $input.nums|first }
    var $max_global { value = $input.nums|first }
    var $i { value = 1 }
    
    // Iterate through array starting from second element
    while ($i < ($input.nums|count)) {
      each {
        // Get current number
        var $current { value = $input.nums[$i] }
        
        // Kadane's algorithm: either start new subarray at current element
        // or extend existing subarray
        conditional {
          if (`$current > ($max_current + $current)`) {
            var $max_current { value = $current }
          }
          else {
            var $max_current { value = $max_current + $current }
          }
        }
        
        // Update global maximum if current is better
        conditional {
          if ($max_current > $max_global) {
            var $max_global { value = $max_current }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $max_global
}
