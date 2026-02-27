function "min_subarray_len" {
  description = "Find the minimal length of a contiguous subarray with sum >= target"
  input {
    int target { description = "Target sum that the subarray must reach or exceed" }
    int[] nums { description = "Array of positive integers" }
  }
  stack {
    // Edge case: empty array
    conditional {
      if (($nums|count) == 0) {
        return { value = 0 }
      }
    }

    var $min_len { value = 0 }
    var $left { value = 0 }
    var $current_sum { value = 0 }

    // Sliding window: expand with right pointer, contract with left pointer
    foreach ($nums) {
      each as $num {
        // Add current element to window
        var.update $current_sum { value = $current_sum + $num }

        // Shrink window from left while sum is still >= target
        while ($current_sum >= $input.target) {
          each {
            // Calculate current window size
            var $window_size { value = $index - $left + 1 }

            // Update min length if this is smaller (or first valid window)
            conditional {
              if ($min_len == 0 || $window_size < $min_len) {
                var.update $min_len { value = $window_size }
              }
            }

            // Remove leftmost element and move left pointer
            var.update $current_sum { value = $current_sum - $nums[$left] }
            var.update $left { value = $left + 1 }
          }
        }
      }
    }
  }
  response = $min_len
}
