function "find_maximum_subarray" {
  description = "Find the contiguous subarray with the largest sum using Kadane's Algorithm"
  
  input {
    int[] nums
  }
  
  stack {
    // Handle edge case: empty array
    precondition (`$input.nums|count > 0`) {
      error_type = "inputerror"
      error = "Input array cannot be empty"
    }
    
    // Initialize Kadane's algorithm variables
    // max_ending_here tracks the maximum sum of subarray ending at current position
    // max_so_far tracks the global maximum sum found
    var $max_ending_here { value = $input.nums|first }
    var $max_so_far { value = $input.nums|first }
    
    // Start from the second element (index 1)
    var $index { value = 1 }
    
    while ($index < ($input.nums|count)) {
      each {
        // Get current element
        var $current { value = $input.nums[$index] }
        
        // Decide whether to start new subarray at current element
        // or extend the existing subarray
        conditional {
          if ($max_ending_here + $current < $current) {
            // Starting new subarray is better
            var.update $max_ending_here { value = $current }
          }
          else {
            // Extending existing subarray is better
            var.update $max_ending_here { value = $max_ending_here + $current }
          }
        }
        
        // Update global maximum if current is better
        conditional {
          if ($max_ending_here > $max_so_far) {
            var.update $max_so_far { value = $max_ending_here }
          }
        }
        
        // Move to next element
        var.update $index { value = $index + 1 }
      }
    }
    
    // Prepare response
    var $result { value = { max_sum: $max_so_far } }
  }
  
  response = $result
}
