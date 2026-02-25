// Valid Perfect Square - Binary search approach
// Given a positive integer num, return true if num is a perfect square
// Uses binary search to avoid sqrt() function - O(log n) time complexity
function "valid_perfect_square" {
  description = "Determines if a number is a perfect square using binary search"

  input {
    int num { description = "Positive integer to check" }
  }

  stack {
    // Edge case: 0 and 1 are perfect squares
    var $is_perfect_square { value = false }
    
    conditional {
      if ($input.num < 0) {
        var $is_perfect_square { value = false }
      }
      elseif (($input.num == 0) || ($input.num == 1)) {
        var $is_perfect_square { value = true }
      }
      else {
        // Binary search for the square root
        var $left { value = 1 }
        var $right { value = $input.num / 2 }
        var $found { value = false }
        
        while (($left <= $right) && !$found) {
          each {
            var $mid { value = $left + (($right - $left) / 2) }
            var $mid_squared { value = $mid * $mid }
            
            conditional {
              // Found exact match
              if ($mid_squared == $input.num) {
                var $found { value = true }
                var $is_perfect_square { value = true }
              }
              // Mid is too small, search right half
              elseif ($mid_squared < $input.num) {
                var $left { value = $mid + 1 }
              }
              // Mid is too large, search left half
              else {
                var $right { value = $mid - 1 }
              }
            }
          }
        }
      }
    }
  }

  response = $is_perfect_square
}
