function "max_average_subarray" {
  description = "Find the contiguous subarray of length k with maximum average value"
  input {
    int[] nums { description = "Array of integers" }
    int k filters=min:1 { description = "Length of subarray" }
  }
  stack {
    // Validate that k is not larger than the array
    precondition (($input.nums|count) >= $input.k) {
      error_type = "inputerror"
      error = "k cannot be larger than array length"
    }
    
    // Calculate sum of first window (0 to k-1)
    var $window_sum { value = 0 }
    for ($input.k) {
      each as $i {
        var.update $window_sum { value = $window_sum + $input.nums[$i] }
      }
    }
    
    // Initialize max_sum with first window sum
    var $max_sum { value = $window_sum }
    
    // Slide the window: remove leftmost element, add new right element
    var $array_length { value = $input.nums|count }
    var $start_index { value = $input.k }
    
    while ($start_index < $array_length) {
      each {
        // Subtract element leaving the window (left side)
        var $left_element { value = $input.nums[$start_index - $input.k] }
        // Add element entering the window (right side)
        var $right_element { value = $input.nums[$start_index] }
        
        var.update $window_sum { 
          value = $window_sum - $left_element + $right_element 
        }
        
        // Update max_sum if current window is larger
        conditional {
          if ($window_sum > $max_sum) {
            var.update $max_sum { value = $window_sum }
          }
        }
        
        // Move window forward
        var.update $start_index { value = $start_index + 1 }
      }
    }
    
    // Calculate max average from max_sum
    var $max_average { 
      value = $max_sum / $input.k 
    }
  }
  response = $max_average
}
