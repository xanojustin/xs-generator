// Find K Closest Elements - Classic coding exercise
// Given a sorted array, find the k closest elements to a target value x
// Returns the k closest integers in sorted order (smaller to larger)
function "find_k_closest_elements" {
  description = "Finds k closest elements to target x in a sorted array"
  
  input {
    int[] arr { description = "Sorted array of integers" }
    int k { description = "Number of closest elements to find" }
    int x { description = "Target value to find closest elements to" }
  }
  
  stack {
    // Handle edge cases using a flag and conditional result
    var $result { value = [] }
    var $is_edge_case { value = false }
    
    conditional {
      if ($input.k <= 0) {
        var $is_edge_case { value = true }
        var $result { value = [] }
      }
      elseif (($input.arr|count) == 0) {
        var $is_edge_case { value = true }
        var $result { value = [] }
      }
      elseif ($input.k >= ($input.arr|count)) {
        var $is_edge_case { value = true }
        var $result { value = $input.arr }
      }
    }
    
    // Only proceed with main logic if not an edge case
    conditional {
      if (!$is_edge_case) {
        // Binary search to find the closest position to x
        var $left { value = 0 }
        var $right { value = ($input.arr|count) - 1 }
        
        while ($left < $right) {
          each {
            var $mid { value = ($left + $right) / 2 }
            
            conditional {
              if (($input.arr|get:$mid) < $input.x) {
                var $left { value = $mid + 1 }
              }
              else {
                var $right { value = $mid }
              }
            }
          }
        }
        
        // Now expand outward using two pointers to find k closest
        var $left_ptr { value = $left - 1 }
        var $right_ptr { value = $left }
        var $count { value = 0 }
        
        while ($count < $input.k) {
          each {
            conditional {
              // If left pointer is out of bounds, take from right
              if ($left_ptr < 0) {
                var $result {
                  value = $result|merge:[$input.arr|get:$right_ptr]
                }
                var $right_ptr { value = $right_ptr + 1 }
              }
              // If right pointer is out of bounds, take from left
              elseif ($right_ptr >= ($input.arr|count)) {
                var $left_val { value = $input.arr|get:$left_ptr }
                var $result {
                  value = [$left_val]|merge:$result
                }
                var $left_ptr { value = $left_ptr - 1 }
              }
              // Compare distances and pick closer one
              // Use abs to compare distances properly
              elseif (($input.x - ($input.arr|get:$left_ptr)) <= (($input.arr|get:$right_ptr) - $input.x)) {
                var $left_val { value = $input.arr|get:$left_ptr }
                var $result {
                  value = [$left_val]|merge:$result
                }
                var $left_ptr { value = $left_ptr - 1 }
              }
              else {
                var $result {
                  value = $result|merge:[$input.arr|get:$right_ptr]
                }
                var $right_ptr { value = $right_ptr + 1 }
              }
            }
            var $count { value = $count + 1 }
          }
        }
      }
    }
  }
  
  response = $result
}
