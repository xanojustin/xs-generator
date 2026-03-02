function "split_array_largest_sum" {
  description = "Split array into m subarrays to minimize the largest sum among them"
  input {
    int[] nums { description = "Array of non-negative integers" }
    int m filters=min:1 { description = "Number of subarrays to split into" }
  }
  stack {
    // Edge case: if m is 1, return sum of all elements
    conditional {
      if ($input.m == 1) {
        var $sum { value = 0 }
        foreach ($input.nums) {
          each as $num {
            var.update $sum { value = $sum + $num }
          }
        }
        return { value = $sum }
      }
    }

    // Edge case: if m equals array length, return max element
    conditional {
      if ($input.m == ($input.nums|count)) {
        var $max { value = 0 }
        foreach ($input.nums) {
          each as $num {
            conditional {
              if ($num > $max) {
                var.update $max { value = $num }
              }
            }
          }
        }
        return { value = $max }
      }
    }

    // Binary search on the answer
    // The minimum possible largest sum is the max element
    // The maximum possible largest sum is the sum of all elements
    var $left { value = 0 }
    var $right { value = 0 }

    foreach ($input.nums) {
      each as $num {
        // left = max element
        conditional {
          if ($num > $left) {
            var.update $left { value = $num }
          }
        }
        // right = sum of all elements
        var.update $right { value = $right + $num }
      }
    }

    var $result { value = $right }

    // Binary search
    while ($left <= $right) {
      each {
        var $mid { value = ($left + $right) / 2 }

        // Check if we can split into m subarrays with max sum <= mid
        var $subarrays_needed { value = 1 }
        var $current_sum { value = 0 }
        var $possible { value = true }

        foreach ($input.nums) {
          each as $num {
            conditional {
              if (($current_sum + $num) <= $mid) {
                var.update $current_sum { value = $current_sum + $num }
              }
              else {
                var.update $subarrays_needed { value = $subarrays_needed + 1 }
                var.update $current_sum { value = $num }
                conditional {
                  if ($subarrays_needed > $input.m) {
                    var.update $possible { value = false }
                  }
                }
              }
            }
          }
        }

        conditional {
          if ($possible) {
            var.update $result { value = $mid }
            var.update $right { value = $mid - 1 }
          }
          else {
            var.update $left { value = $mid + 1 }
          }
        }
      }
    }
  }
  response = $result
}
