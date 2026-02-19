function "merge_sort" {
  description = "Sort an array of integers using the merge sort algorithm (divide-and-conquer)"
  input {
    int[] numbers {
      description = "Array of integers to sort"
    }
  }
  stack {
    var $arr { value = $input.numbers }
    var $n { value = $arr|count }
    
    // Handle empty or single-element arrays (already sorted)
    conditional {
      if ($n <= 1) {
        // Return early - array is already sorted
      }
      else {
        // Bottom-up merge sort: start with subarrays of size 1, then 2, 4, 8, etc.
        var $width { value = 1 }
        
        while ($width < $n) {
          each {
            var $i { value = 0 }
            
            // Merge subarrays of current width
            while ($i < $n) {
              each {
                // Calculate bounds for left and right subarrays
                var $left_start { value = $i }
                var $left_end { value = ($i + $width - 1)|min:($n - 1) }
                var $right_start { value = $i + $width }
                var $right_end { value = ($i + 2 * $width - 1)|min:($n - 1) }
                
                // Only merge if there's a right subarray
                conditional {
                  if ($right_start <= $right_end) {
                    // Merge the two subarrays: arr[left_start..left_end] and arr[right_start..right_end]
                    var $merged { value = [] }
                    var $l { value = $left_start }
                    var $r { value = $right_start }
                    
                    // Compare and merge elements from both subarrays
                    while ($l <= $left_end && $r <= $right_end) {
                      each {
                        conditional {
                          if ($arr[$l] <= $arr[$r]) {
                            var $merged { value = $merged|merge:[$arr[$l]] }
                            var.update $l { value = $l + 1 }
                          }
                          else {
                            var $merged { value = $merged|merge:[$arr[$r]] }
                            var.update $r { value = $r + 1 }
                          }
                        }
                      }
                    }
                    
                    // Add remaining elements from left subarray
                    while ($l <= $left_end) {
                      each {
                        var $merged { value = $merged|merge:[$arr[$l]] }
                        var.update $l { value = $l + 1 }
                      }
                    }
                    
                    // Add remaining elements from right subarray
                    while ($r <= $right_end) {
                      each {
                        var $merged { value = $merged|merge:[$arr[$r]] }
                        var.update $r { value = $r + 1 }
                      }
                    }
                    
                    // Copy merged elements back to original array
                    var $k { value = 0 }
                    var $pos { value = $left_start }
                    while ($pos <= $right_end) {
                      each {
                        var.update $arr { value = $arr|set:$pos:($merged[$k]) }
                        var.update $k { value = $k + 1 }
                        var.update $pos { value = $pos + 1 }
                      }
                    }
                  }
                }
                
                var.update $i { value = $i + (2 * $width) }
              }
            }
            
            var.update $width { value = $width * 2 }
          }
        }
      }
    }
  }
  response = $arr
}
