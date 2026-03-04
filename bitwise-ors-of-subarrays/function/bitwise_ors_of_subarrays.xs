// Bitwise ORs of Subarrays - LeetCode 898
// Given an array of integers, return the number of distinct bitwise OR values
// of all possible subarrays.
//
// Algorithm: For each element, we track all OR results ending at that position.
// Each new element can either start a new subarray or extend existing ones.
// We use a set to collect all distinct OR values.
function "bitwise_ors_of_subarrays" {
  description = "Counts distinct bitwise OR results of all subarrays"

  input {
    int[] nums { description = "Array of non-negative integers" }
  }

  stack {
    // Set to store all distinct OR values (as object keys for uniqueness)
    var $distinct_ors { value = {} }
    
    // Current set of OR values ending at previous position
    var $current_ors { value = [] }
    
    // Manual index for iterating through array
    var $i { value = 0 }
    var $n { value = $input.nums|count }
    
    while ($i < $n) {
      each {
        // Get current number
        var $num { value = $input.nums[$i] }
        
        // New set of OR values ending at current position
        var $new_ors { value = [] }
        
        // Start a new subarray at current position
        var $new_ors {
          value = $new_ors|merge:[$num]
        }
        
        // Add current OR to distinct set
        var $num_key { value = $num|to_text }
        conditional {
          if (!($distinct_ors|has:$num_key)) {
            var $distinct_ors {
              value = $distinct_ors|merge:{
                $num_key: true
              }
            }
          }
        }
        
        // Extend all previous subarrays with current number
        var $j { value = 0 }
        var $current_count { value = $current_ors|count }
        
        while ($j < $current_count) {
          each {
            var $prev_or { value = $current_ors[$j] }
            var $combined { value = $prev_or | bor:$num }
            var $new_ors {
              value = $new_ors|merge:[$combined]
            }
            
            // Add combined OR to distinct set
            var $combined_key { value = $combined|to_text }
            conditional {
              if (!($distinct_ors|has:$combined_key)) {
                var $distinct_ors {
                  value = $distinct_ors|merge:{
                    $combined_key: true
                  }
                }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        
        // Update current_ors for next iteration
        var $current_ors { value = $new_ors }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Count distinct OR values (number of keys in the object)
    var $count { value = $distinct_ors|count }
  }

  response = $count
}
