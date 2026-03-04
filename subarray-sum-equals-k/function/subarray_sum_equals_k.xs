// Subarray Sum Equals K - LeetCode 560
// Given an array of integers and an integer k, return the total number of
// continuous subarrays whose sum equals to k.
//
// Algorithm: Use prefix sum with hash map. For each position, compute prefix sum.
// If (prefix_sum - k) exists in the map, it means there's a subarray ending at
// current position with sum = k. Use a map to store prefix sum frequencies.
function "subarray_sum_equals_k" {
  description = "Counts subarrays with sum equal to k"

  input {
    int[] nums { description = "Array of integers" }
    int k { description = "Target sum value" }
  }

  stack {
    // Hash map to store prefix sum frequencies
    // Key: prefix sum (as text), Value: count
    var $prefix_counts { 
      value = {
        "0": 1
      }
    }
    
    // Current prefix sum
    var $prefix_sum { value = 0 }
    
    // Result count
    var $count { value = 0 }
    
    // Iterate through array
    var $i { value = 0 }
    var $n { value = $input.nums|count }
    
    while ($i < $n) {
      each {
        // Add current number to prefix sum
        var $prefix_sum { value = $prefix_sum + $input.nums[$i] }
        
        // Check if (prefix_sum - k) exists in the map
        var $needed { value = $prefix_sum - $input.k }
        var $needed_key { value = $needed|to_text }
        
        conditional {
          if ($prefix_counts|has:$needed_key) {
            // Add the frequency of (prefix_sum - k) to count
            var $freq { value = $prefix_counts|get:$needed_key }
            var $count { value = $count + $freq }
          }
        }
        
        // Update prefix sum frequency in map
        var $current_key { value = $prefix_sum|to_text }
        var $current_freq { value = 0 }
        
        conditional {
          if ($prefix_counts|has:$current_key) {
            var $current_freq { value = $prefix_counts|get:$current_key }
          }
        }
        
        var $new_freq { value = $current_freq + 1 }
        var $prefix_counts {
          value = $prefix_counts|merge:{
            $current_key: $new_freq
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $count
}
