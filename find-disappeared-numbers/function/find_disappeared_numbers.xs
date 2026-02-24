// Find All Numbers Disappeared in an Array
// Given an array where 1 <= nums[i] <= n, find all numbers in [1, n] not present
function "find_disappeared_numbers" {
  description = "Finds all numbers in range [1, n] that do not appear in the input array"
  
  input {
    int[] nums { description = "Array of integers where 1 <= nums[i] <= length" }
  }
  
  stack {
    // Create a mutable copy of the input array for marking
    var $marked_nums { value = $input.nums }
    var $n { value = $input.nums|count }
    var $i { value = 0 }
    
    // Phase 1: Mark visited indices by negating values
    while ($i < $n) {
      each {
        var $current_num { value = $marked_nums|get:$i }
        var $abs_val { value = $current_num }
        
        // Handle negative values (already marked)
        conditional {
          if ($abs_val < 0) {
            var $abs_val { value = 0 - $abs_val }
          }
        }
        
        // Calculate target index (value - 1 for 0-indexed array)
        var $target_index { value = $abs_val - 1 }
        
        // Mark the target index as visited (make negative)
        conditional {
          if ($target_index >= 0 && $target_index < $n) {
            var $target_value { value = $marked_nums|get:$target_index }
            conditional {
              if ($target_value > 0) {
                var $new_value { value = 0 - $target_value }
                var $marked_nums { value = $marked_nums|set:$target_index:$new_value }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Phase 2: Collect missing numbers (indices with positive values)
    var $missing { value = [] }
    var $j { value = 0 }
    
    while ($j < $n) {
      each {
        var $val { value = $marked_nums|get:$j }
        conditional {
          if ($val > 0) {
            var $missing_num { value = $j + 1 }
            var $missing { value = $missing|merge:[$missing_num] }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  
  response = $missing
}
