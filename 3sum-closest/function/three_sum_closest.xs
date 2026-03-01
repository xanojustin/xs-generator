// 3Sum Closest - Classic coding exercise
// Given an array of integers and a target, return the sum of three integers closest to target
// Uses sorting + two-pointer approach for O(n²) time complexity
function "three_sum_closest" {
  description = "Finds three integers whose sum is closest to target"
  
  input {
    int[] nums { description = "Array of integers to search" }
    int target { description = "Target sum value" }
  }
  
  stack {
    // Handle edge case: less than 3 elements
    conditional {
      if (($input.nums|count) < 3) {
        return { value = 0 }
      }
    }
    
    // Sort the array
    var $sorted { value = $input.nums|sort }
    
    // Initialize closest sum with first three elements
    var $closest_sum { 
      value = ($sorted[0]) + ($sorted[1]) + ($sorted[2])
    }
    
    // Iterate through array, using each element as first of triplet
    var $i { value = 0 }
    var $n { value = $input.nums|count }
    
    while ($i < ($n - 2)) {
      each {
        // Two pointers: left starts after i, right starts at end
        var $left { value = $i + 1 }
        var $right { value = $n - 1 }
        
        while ($left < $right) {
          each {
            var $current_sum {
              value = ($sorted[$i]) + ($sorted[$left]) + ($sorted[$right])
            }
            
            // Update closest if current is closer to target
            var $current_diff { value = $current_sum - $input.target }
            var $closest_diff { value = $closest_sum - $input.target }
            
            // Use absolute values for comparison
            conditional {
              if ($current_diff < 0) {
                var $current_diff { value = 0 - $current_diff }
              }
            }
            conditional {
              if ($closest_diff < 0) {
                var $closest_diff { value = 0 - $closest_diff }
              }
            }
            
            conditional {
              if ($current_diff < $closest_diff) {
                var $closest_sum { value = $current_sum }
              }
            }
            
            // Move pointers based on comparison with target
            conditional {
              if ($current_sum < $input.target) {
                var $left { value = $left + 1 }
              }
              elseif ($current_sum > $input.target) {
                var $right { value = $right - 1 }
              }
              else {
                // Exact match found - can't get closer than this
                return { value = $current_sum }
              }
            }
          }
        }
        
        var $i { value = $i + 1 }
      }
    }
    
    return { value = $closest_sum }
  }
  
  response = $result
}
