function "max_subarray_circular" {
  description = "Find the maximum subarray sum in a circular array"
  input {
    int[] nums
  }
  stack {
    // Handle empty array
    precondition (($nums|count) > 0) {
      error_type = "inputerror"
      error = "Array cannot be empty"
    }

    // Handle single element
    conditional {
      if (($nums|count) == 1) {
        return { value = $nums|first }
      }
    }

    // Initialize variables for Kadane's algorithm
    var $max_current { value = $nums|first }
    var $max_global { value = $nums|first }
    var $min_current { value = $nums|first }
    var $min_global { value = $nums|first }
    var $total_sum { value = $nums|first }

    // Iterate through array starting from index 1
    foreach ($nums|slice:1:(($nums|count) - 1)) {
      each as $num {
        // Update total sum
        var.update $total_sum { value = $total_sum + $num }

        // Kadane's algorithm for max subarray
        var $max_candidate { value = $num }
        conditional {
          if (($max_current + $num) > $num) {
            var.update $max_candidate { value = $max_current + $num }
          }
        }
        var.update $max_current { value = $max_candidate }
        conditional {
          if ($max_current > $max_global) {
            var.update $max_global { value = $max_current }
          }
        }

        // Kadane's algorithm for min subarray (for circular case)
        var $min_candidate { value = $num }
        conditional {
          if (($min_current + $num) < $num) {
            var.update $min_candidate { value = $min_current + $num }
          }
        }
        var.update $min_current { value = $min_candidate }
        conditional {
          if ($min_current < $min_global) {
            var.update $min_global { value = $min_current }
          }
        }
      }
    }

    // Handle circular case
    // The maximum circular subarray is either:
    // 1. The regular max subarray (no wrap)
    // 2. Total sum - minimum subarray sum (wraps around)
    // Edge case: If all numbers are negative, min subarray equals total sum,
    // so we should only return the regular max subarray

    var $circular_max { value = $total_sum - $min_global }

    conditional {
      if ($circular_max == 0) {
        // All numbers are negative, return regular max
        var $result { value = $max_global }
      }
      else {
        conditional {
          if ($circular_max > $max_global) {
            var $result { value = $circular_max }
          }
          else {
            var $result { value = $max_global }
          }
        }
      }
    }
  }
  response = $result
}
