// Find Minimum in Rotated Sorted Array
// Given a sorted array that has been rotated between 1 and n times,
// find the minimum element. The array contains unique elements.
// Uses modified binary search for O(log n) time complexity.
function "find_minimum_rotated" {
  description = "Finds the minimum element in a rotated sorted array"

  input {
    int[] nums { description = "Rotated sorted array of unique integers" }
  }

  stack {
    // Handle edge case: empty array
    var $n { value = $input.nums|count }
    
    conditional {
      if ($n == 0) {
        var $result { value = null }
      }
      // Single element array
      elseif ($n == 1) {
        var $result { value = $input.nums[0] }
      }
      else {
        // Initialize binary search pointers
        var $left { value = 0 }
        var $right { value = $n - 1 }
        var $min_val { value = $input.nums[0] }

        // Binary search to find minimum
        while ($left <= $right) {
          each {
            var $mid { value = $left + (($right - $left) / 2) }
            var $mid_val { value = $input.nums[$mid] }

            // Update minimum found so far
            conditional {
              if ($mid_val < $min_val) {
                var $min_val { value = $mid_val }
              }
            }

            // Determine which half contains the minimum
            // Compare mid element with rightmost element
            conditional {
              // Right side is sorted, so minimum must be on the left side
              // (including mid or before mid)
              if ($mid_val < $input.nums[$right]) {
                var $right { value = $mid - 1 }
              }
              // Left side is sorted, so minimum must be on the right side
              // (after mid)
              elseif ($mid_val > $input.nums[$right]) {
                var $left { value = $mid + 1 }
              }
              // Equal case shouldn't happen with unique elements,
              // but handle it by moving right pointer
              else {
                var $right { value = $mid - 1 }
              }
            }
          }
        }

        var $result { value = $min_val }
      }
    }
  }

  response = $result
}
