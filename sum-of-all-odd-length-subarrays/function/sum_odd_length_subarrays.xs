function "sum_odd_length_subarrays" {
  description = "Calculate the sum of all odd-length subarrays"
  
  input {
    int[] arr
  }
  
  stack {
    // Total sum of all odd-length subarrays
    var $total_sum { value = 0 }
    
    // Get array length
    var $n { value = $arr|count }
    
    // Iterate over all possible starting positions
    for ($n) {
      each as $start {
        // Iterate over all possible ending positions (starting from start)
        var $remaining { value = $n - $start }
        for ($remaining) {
          each as $offset {
            var $end { value = $start + $offset }
            var $length { value = $end - $start + 1 }
            
            // Only process odd-length subarrays
            conditional {
              if (($length % 2) == 1) {
                // Calculate sum of this subarray
                var $subarray_sum { value = 0 }
                var $sub_length { value = $length }
                for ($sub_length) {
                  each as $k {
                    var $idx { value = $start + $k }
                    var.update $subarray_sum { value = $subarray_sum + $arr[$idx] }
                  }
                }
                // Add to total
                var.update $total_sum { value = $total_sum + $subarray_sum }
              }
            }
          }
        }
      }
    }
  }
  
  response = $total_sum
}
