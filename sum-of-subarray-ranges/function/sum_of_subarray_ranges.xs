// Sum of Subarray Ranges
// Calculates the sum of (max - min) for all possible subarrays
function "sum_of_subarray_ranges" {
  description = "Calculate the sum of all subarray ranges"
  
  input {
    int[] nums { description = "Array of integers" }
  }
  
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Handle edge case: single element
    conditional {
      if (($input.nums|count) == 1) {
        return { value = 0 }
      }
    }
    
    var $n { value = $input.nums|count }
    var $total_sum { value = 0 }
    var $i { value = 0 }
    
    // Iterate over all possible subarrays
    while ($i < $n) {
      each {
        var $j { value = $i }
        
        while ($j < $n) {
          each {
            // Extract subarray from i to j
            var $subarray { value = $input.nums|slice:$i:($j + 1) }
            
            // Find min and max of subarray
            var $min_val { value = $subarray|min }
            var $max_val { value = $subarray|max }
            
            // Add range to total
            var $range { value = $max_val - $min_val }
            var.update $total_sum { value = $total_sum + $range }
            
            var.update $j { value = $j + 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $total_sum
}
