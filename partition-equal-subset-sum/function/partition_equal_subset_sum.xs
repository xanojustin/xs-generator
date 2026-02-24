// Partition Equal Subset Sum - Dynamic Programming Problem
// Given an array of integers, determine if it can be partitioned into two subsets with equal sum
function "partition_equal_subset_sum" {
  description = "Determines if an array can be partitioned into two subsets with equal sum"

  input {
    int[] nums { description = "Array of positive integers" }
  }

  stack {
    // Calculate total sum of array
    var $total { value = 0 }
    foreach ($input.nums) {
      each as $num {
        var.update $total { value = $total + $num }
      }
    }

    // If total is odd, cannot partition equally
    conditional {
      if (($total % 2) != 0) {
        return { value = false }
      }
    }

    // Target sum for each subset
    var $target { value = $total / 2 }

    // Edge case: empty array or single element
    conditional {
      if (($input.nums|count) == 0) {
        return { value = false }
      }
      elseif (($input.nums|count) == 1) {
        return { value = false }
      }
    }

    // Edge case: if max element equals target, we found a partition
    var $max_num { value = 0 }
    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($num > $max_num) {
            var $max_num { value = $num }
          }
        }
      }
    }

    conditional {
      if ($max_num > $target) {
        return { value = false }
      }
      elseif ($max_num == $target) {
        return { value = true }
      }
    }

    // Dynamic programming approach: dp[i] = true if sum i is achievable
    // Using a boolean array where index represents the sum
    var $dp { value = [] }
    var $i { value = 0 }
    while ($i <= $target) {
      each {
        conditional {
          if ($i == 0) {
            var $dp { value = $dp|merge:[true] }
          }
          else {
            var $dp { value = $dp|merge:[false] }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Process each number in the array
    foreach ($input.nums) {
      each as $num {
        // Update dp array backwards to avoid using updated values
        var $j { value = $target }
        while ($j >= $num) {
          each {
            conditional {
              if ($dp[$j - $num]) {
                var $dp { 
                  value = $dp|set:$j:true
                }
              }
            }
            var.update $j { value = $j - 1 }
          }
        }
      }
    }

    // Result is whether target sum is achievable
    var $can_partition { value = $dp[$target] }
  }

  response = $can_partition
}
