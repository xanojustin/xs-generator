// Subarray Sum Equals K - Classic coding exercise
// Given an array of integers and a target k, return the total number of continuous subarrays
// whose sum equals k. Uses prefix sum with hash map for O(n) time complexity.
function "subarray_sum" {
  description = "Counts continuous subarrays with sum equal to k"

  input {
    int[] nums { description = "Array of integers to search" }
    int k { description = "Target sum value" }
  }

  stack {
    // Hash map to store prefix sum frequencies
    // Key: prefix sum, Value: count of times this sum has occurred
    var $prefix_counts { value = { "0": 1 } }
    var $count { value = 0 }
    var $current_sum { value = 0 }

    foreach ($input.nums) {
      each as $num {
        // Update running prefix sum
        var $current_sum { value = $current_sum + $num }

        // Check if (current_sum - k) exists in prefix counts
        // This means there's a subarray ending at current index with sum = k
        var $target_prefix { value = $current_sum - $input.k }
        var $target_key { value = $target_prefix|to_text }

        conditional {
          if ($prefix_counts|has:$target_key) {
            // Found subarrays ending here that sum to k
            var $prefix_count {
              value = $prefix_counts|get:$target_key
            }
            var $count { value = $count + $prefix_count }
          }
        }

        // Update prefix_counts with current_sum
        var $current_key { value = $current_sum|to_text }
        var $current_count { value = 0 }

        conditional {
          if ($prefix_counts|has:$current_key) {
            var $current_count {
              value = $prefix_counts|get:$current_key
            }
          }
        }

        var $prefix_counts {
          value = $prefix_counts|set:$current_key:($current_count + 1)
        }
      }
    }
  }

  response = $count
}
