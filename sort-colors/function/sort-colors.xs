// Sort Colors - Dutch National Flag Problem
// Sorts an array containing only 0s, 1s, and 2s in-place
// Uses three pointers: low, mid, and high for single-pass sorting
function "sort-colors" {
  description = "Sorts an array of 0s, 1s, and 2s in-place using Dutch National Flag algorithm"
  
  input {
    int[] nums { description = "Array containing only 0s, 1s, and 2s to be sorted in-place" }
  }
  
  stack {
    // Copy input array since we need to modify it
    var $arr { value = $input.nums }
    
    // Edge case: empty array or single element
    conditional {
      if (($arr|count) <= 1) {
        return { value = $arr }
      }
    }
    
    // Initialize three pointers
    var $low { value = 0 }
    var $mid { value = 0 }
    var $high { value = ($arr|count) - 1 }
    
    // Dutch National Flag algorithm
    // While mid hasn't crossed high
    while ($mid <= $high) {
      each {
        conditional {
          // If current element is 0, swap with low pointer and advance both
          if (($arr|get:$mid|to_int) == 0) {
            // Swap arr[low] and arr[mid]
            var $temp { value = $arr|get:$low }
            var $arr { value = $arr|set:$low:($arr|get:$mid) }
            var $arr { value = $arr|set:$mid:$temp }
            
            var.update $low { value = $low + 1 }
            var.update $mid { value = $mid + 1 }
          }
          // If current element is 1, just advance mid
          elseif (($arr|get:$mid|to_int) == 1) {
            var.update $mid { value = $mid + 1 }
          }
          // If current element is 2, swap with high pointer and decrement high
          else {
            // Swap arr[mid] and arr[high]
            var $temp { value = $arr|get:$mid }
            var $arr { value = $arr|set:$mid:($arr|get:$high) }
            var $arr { value = $arr|set:$high:$temp }
            
            var.update $high { value = $high - 1 }
            // Note: don't advance mid here, need to check the swapped element
          }
        }
      }
    }
  }
  
  response = $arr
}
