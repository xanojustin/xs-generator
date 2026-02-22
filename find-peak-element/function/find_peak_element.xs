// Find Peak Element - Classic binary search interview problem
// A peak element is an element that is strictly greater than its neighbors
// Given an array, find the index of a peak element (any one if multiple exist)
// Uses binary search for O(log n) time complexity
function "find_peak_element" {
  description = "Finds the index of a peak element using binary search"

  input {
    int[] nums { description = "Array of integers" }
  }

  stack {
    var $n { value = $input.nums|count }

    conditional {
      // Empty array - no peak
      if ($n == 0) {
        var $result { value = -1 }
      }
      // Single element - it's a peak
      elseif ($n == 1) {
        var $result { value = 0 }
      }
      else {
        // Binary search for a peak
        var $left { value = 0 }
        var $right { value = $n - 1 }
        var $peak_index { value = -1 }

        while (($left <= $right) && ($peak_index == -1)) {
          each {
            var $mid { value = $left + (($right - $left) / 2) }
            var $mid_val { value = $input.nums[$mid] }

            // Get left and right neighbors (handle boundaries)
            conditional {
              if ($mid == 0) {
                // First element - only compare with right
                conditional {
                  if ($mid_val > $input.nums[$mid + 1]) {
                    var $peak_index { value = $mid }
                  }
                  else {
                    // Peak must be to the right
                    var $left { value = $mid + 1 }
                  }
                }
              }
              elseif ($mid == ($n - 1)) {
                // Last element - only compare with left
                conditional {
                  if ($mid_val > $input.nums[$mid - 1]) {
                    var $peak_index { value = $mid }
                  }
                  else {
                    // Peak must be to the left
                    var $right { value = $mid - 1 }
                  }
                }
              }
              else {
                // Middle element - compare with both neighbors
                var $left_val { value = $input.nums[$mid - 1] }
                var $right_val { value = $input.nums[$mid + 1] }

                conditional {
                  // Found a peak
                  if (($mid_val > $left_val) && ($mid_val > $right_val)) {
                    var $peak_index { value = $mid }
                  }
                  // Left side has higher value, peak is on left
                  elseif ($left_val > $mid_val) {
                    var $right { value = $mid - 1 }
                  }
                  // Right side has higher or equal value, peak is on right
                  else {
                    var $left { value = $mid + 1 }
                  }
                }
              }
            }
          }
        }

        var $result { value = $peak_index }
      }
    }
  }

  response = $result
}
