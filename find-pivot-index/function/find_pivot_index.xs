function "find_pivot_index" {
  description = "Finds the pivot index where left sum equals right sum"
  
  input {
    int[] nums { description = "Array of integers to search for pivot index" }
  }
  
  stack {
    // Calculate total sum of array
    var $total_sum { value = 0 }
    var $i { value = 0 }
    while ($i < ($input.nums|count)) {
      each {
        var.update $total_sum { value = $total_sum + ($input.nums[$i]) }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Iterate to find pivot index
    var $left_sum { value = 0 }
    var $index { value = 0 }
    
    while ($index < ($input.nums|count)) {
      each {
        // Calculate right sum: total - left - current
        var $right_sum { value = $total_sum - $left_sum - ($input.nums[$index]) }
        
        // Check if left sum equals right sum
        conditional {
          if ($left_sum == $right_sum) {
            return { value = $index }
          }
        }
        
        // Add current element to left sum and move to next
        var.update $left_sum { value = $left_sum + ($input.nums[$index]) }
        var.update $index { value = $index + 1 }
      }
    }
    
    // No pivot index found
    return { value = -1 }
  }
  
  response = $result
}
