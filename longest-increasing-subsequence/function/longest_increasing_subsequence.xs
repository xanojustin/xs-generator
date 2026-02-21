// Longest Increasing Subsequence - Classic dynamic programming exercise
// Given an array of integers, find the length of the longest strictly increasing subsequence
// A subsequence is a sequence that can be derived by deleting elements without changing order
function "longest_increasing_subsequence" {
  description = "Returns the length of the longest strictly increasing subsequence"

  input {
    int[] nums { description = "Array of integers" }
  }

  stack {
    // Edge case: empty array
    conditional {
      if (`($input.nums|count) == 0`) {
        return { value = 0 }
      }
    }

    // dp[i] stores the length of LIS ending at index i
    // Initialize all dp values to 1 (each element is a subsequence of length 1)
    var $dp { value = [] }
    var $i { value = 0 }

    // Initialize dp array with 1s
    while ($i < ($input.nums|count)) {
      each {
        var $dp {
          value = $dp|merge:[1]
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Build the dp array
    // For each element, look at all previous elements
    var $i { value = 1 }
    while ($i < ($input.nums|count)) {
      each {
        var $j { value = 0 }

        while ($j < $i) {
          each {
            // Get current values at indices i and j
            var $num_i { value = $input.nums|index:$i }
            var $num_j { value = $input.nums|index:$j }

            conditional {
              // If nums[j] < nums[i], we can extend the subsequence
              if ($num_j < $num_i) {
                var $current_dp_i { value = $dp|index:$i }
                var $dp_j_plus_one { value = ($dp|index:$j) + 1 }

                conditional {
                  // Update dp[i] if we found a longer subsequence
                  if ($dp_j_plus_one > $current_dp_i) {
                    // Replace the value at index i
                    var $before { value = $dp|slice:0:$i }
                    var $after { value = $dp|slice:($i + 1) }
                    var $dp {
                      value = $before|merge:[$dp_j_plus_one]|merge:$after
                    }
                  }
                }
              }
            }

            var.update $j { value = $j + 1 }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }

    // Find the maximum value in dp array
    var $max_length { value = 1 }
    var $k { value = 0 }

    while ($k < ($dp|count)) {
      each {
        var $current { value = $dp|index:$k }
        conditional {
          if ($current > $max_length) {
            var.update $max_length { value = $current }
          }
        }
        var.update $k { value = $k + 1 }
      }
    }
  }

  response = $max_length
}
