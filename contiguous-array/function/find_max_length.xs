// Contiguous Array - Find longest contiguous subarray with equal 0s and 1s
// Algorithm: Treat 0s as -1, use running sum with hash map to find matching sums
function "find_max_length" {
  description = "Finds the longest contiguous subarray with equal number of 0s and 1s"
  
  input {
    int[] nums { description = "Binary array containing only 0s and 1s" }
  }
  
  stack {
    // Hash map to store first occurrence of each running sum
    // Key: running sum, Value: index where sum was first seen
    var $sum_map { value = {} }
    
    // Initialize with sum 0 at index -1 (before array starts)
    // This handles cases where subarray starts from index 0
    var $sum_map {
      value = $sum_map|set:"0":(-1)
    }
    
    var $running_sum { value = 0 }
    var $max_length { value = 0 }
    var $index { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        // Update running sum: treat 0 as -1, 1 as +1
        conditional {
          if ($num == 0) {
            var.update $running_sum {
              value = $running_sum - 1
            }
          }
          else {
            var.update $running_sum {
              value = $running_sum + 1
            }
          }
        }
        
        // Convert running sum to text for map key
        var $sum_key { value = $running_sum|to_text }
        
        // Check if we've seen this sum before
        conditional {
          if ($sum_map|has:$sum_key) {
            // Found a subarray with equal 0s and 1s
            // Calculate length from first occurrence to current index
            var $first_index {
              value = $sum_map|get:$sum_key
            }
            var $current_length {
              value = $index - $first_index
            }
            
            // Update max length if this is longer
            conditional {
              if ($current_length > $max_length) {
                var.update $max_length {
                  value = $current_length
                }
              }
            }
          }
          else {
            // First time seeing this sum, store the index
            var $sum_map {
              value = $sum_map|set:$sum_key:$index
            }
          }
        }
        
        var.update $index {
          value = $index + 1
        }
      }
    }
  }
  
  response = $max_length
}
