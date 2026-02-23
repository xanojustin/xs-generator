function "duplicate_zeros" {
  description = "Given a fixed-length array, duplicate each occurrence of zero, shifting remaining elements to the right. Elements beyond the original length are discarded."
  input {
    int[] arr { description = "Input array of integers" }
  }
  stack {
    // Count zeros to determine how many elements will be shifted
    var $zero_count { value = 0 }
    var $n { value = $input.arr|count }
    
    foreach ($input.arr) {
      each as $num {
        conditional {
          if ($num == 0) {
            var.update $zero_count { value = $zero_count + 1 }
          }
        }
      }
    }
    
    // Calculate new length (elements that would fit before truncation)
    var $new_length { value = $n + $zero_count }
    
    // Work backwards from the end to shift elements in place
    // i = pointer in original array (from end)
    // j = pointer in new conceptual array (from end)
    var $i { value = $n - 1 }
    var $j { value = $new_length - 1 }
    
    // Create result array - we'll work with a copy
    var $result { value = $input.arr }
    
    // We need to modify in place but handle shifting
    // Use a while loop to process from the end
    while ($i >= 0) {
      each {
        conditional {
          // Get current element from original array
          if ($i < $n) {
            var $current { value = $input.arr[$i] }
            
            conditional {
              // If current element is 0, place two zeros if they fit
              if ($current == 0) {
                conditional {
                  if ($j < $n) {
                    var.update $result[$j] { value = 0 }
                  }
                }
                var.update $j { value = $j - 1 }
                conditional {
                  if ($j < $n) {
                    var.update $result[$j] { value = 0 }
                  }
                }
                var.update $j { value = $j - 1 }
              }
              // Otherwise place the non-zero element
              else {
                conditional {
                  if ($j < $n) {
                    var.update $result[$j] { value = $current }
                  }
                }
                var.update $j { value = $j - 1 }
              }
            }
          }
        }
        var.update $i { value = $i - 1 }
      }
    }
  }
  response = $result
}
