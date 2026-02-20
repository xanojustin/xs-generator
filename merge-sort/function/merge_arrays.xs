// Helper function to merge two sorted arrays
function "merge_arrays" {
  description = "Merges two sorted arrays into one sorted array"
  
  input {
    int[] left { description = "First sorted array" }
    int[] right { description = "Second sorted array" }
  }
  
  stack {
    var $result { value = [] }
    var $left_idx { value = 0 }
    var $right_idx { value = 0 }
    var $left_len { value = $input.left|count }
    var $right_len { value = $input.right|count }
    
    // Compare elements from both arrays and add smaller one to result
    while ($left_idx < $left_len && $right_idx < $right_len) {
      each {
        conditional {
          if ($input.left[$left_idx] <= $input.right[$right_idx]) {
            var $result {
              value = $result ~ [$input.left[$left_idx]]
            }
            var.update $left_idx { value = $left_idx + 1 }
          }
          else {
            var $result {
              value = $result ~ [$input.right[$right_idx]]
            }
            var.update $right_idx { value = $right_idx + 1 }
          }
        }
      }
    }
    
    // Add remaining elements from left array (if any)
    while ($left_idx < $left_len) {
      each {
        var $result {
          value = $result ~ [$input.left[$left_idx]]
        }
        var.update $left_idx { value = $left_idx + 1 }
      }
    }
    
    // Add remaining elements from right array (if any)
    while ($right_idx < $right_len) {
      each {
        var $result {
          value = $result ~ [$input.right[$right_idx]]
        }
        var.update $right_idx { value = $right_idx + 1 }
      }
    }
  }
  
  response = $result
}
