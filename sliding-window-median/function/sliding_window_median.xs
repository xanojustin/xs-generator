function "sliding_window_median" {
  description = "Given an array of integers and a window size k, return the median of each sliding window as it moves from left to right."
  
  input {
    int[] nums
    int k
  }
  
  stack {
    // Handle edge cases using elseif chain
    conditional {
      if ($input.k <= 0) {
        return { value = [] }
      }
      elseif (($input.nums|count) == 0) {
        return { value = [] }
      }
      elseif ($input.k > ($input.nums|count)) {
        return { value = [] }
      }
    }
    
    var $result { value = [] }
    var $n { value = $input.nums|count }
    var $window_size { value = $input.k }
    var $num_windows { value = $n - $window_size + 1 }
    
    // Iterate through each window position
    for ($num_windows) {
      each as $i {
        // Extract current window
        var $window { value = [] }
        for ($window_size) {
          each as $j {
            var $idx { value = $i + $j }
            var $elem { value = $input.nums[$idx] }
            var $window { value = $window|push:$elem }
          }
        }
        
        // Sort the window to find median
        var $sorted { value = $window|sort }
        var $mid { value = ($window_size - 1) / 2 }
        
        conditional {
          if (($window_size % 2) == 1) {
            // Odd window size - middle element is median
            var $median { value = $sorted[$mid] }
            var $result { value = $result|push:$median }
          }
          else {
            // Even window size - average of two middle elements
            var $mid2 { value = $mid + 1 }
            var $val1 { value = $sorted[$mid] }
            var $val2 { value = $sorted[$mid2] }
            var $median { value = ($val1 + $val2) / 2 }
            var $result { value = $result|push:$median }
          }
        }
      }
    }
  }
  
  response = $result
}
