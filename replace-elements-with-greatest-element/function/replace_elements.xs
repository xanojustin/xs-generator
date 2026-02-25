// Replace Elements with Greatest Element on Right Side
// Given an array, replace each element with the greatest element to its right,
// and replace the last element with -1
function "replace_elements" {
  description = "Replaces each element with the greatest element to its right"
  
  input {
    int[] arr { description = "Input array of integers" }
  }
  
  stack {
    // Handle empty array
    conditional {
      if (($input.arr|count) == 0) {
        return { value = [] }
      }
    }
    
    var $n { value = $input.arr|count }
    var $result { value = [] }
    var $max_from_right { value = -1 }
    var $i { value = $n - 1 }
    
    // Traverse from right to left
    while ($i >= 0) {
      each {
        // Get current element before we overwrite
        var $current { value = $input.arr[$i] }
        
        // Store max_from_right as the result for this position
        var $result { value = [$max_from_right]|merge:$result }
        
        // Update max_from_right to include current element
        conditional {
          if ($current > $max_from_right) {
            var.update $max_from_right { value = $current }
          }
        }
        
        var.update $i { value = $i - 1 }
      }
    }
  }
  
  response = $result
}
