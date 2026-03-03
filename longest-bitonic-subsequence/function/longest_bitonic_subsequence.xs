// Longest Bitonic Subsequence - Classic dynamic programming exercise
// A bitonic sequence is a sequence that first increases and then decreases
// Given an array of integers, find the length of the longest bitonic subsequence
// Approach: Compute LIS from left to right and from right to left, then combine
function "longest_bitonic_subsequence" {
  description = "Returns the length of the longest bitonic subsequence"

  input {
    int[] nums { description = "Array of integers" }
  }

  stack {
    // Edge case: empty array or single element
    conditional {
      if (`($input.nums|count) <= 1`) {
        return { value = $input.nums|count }
      }
    }

    var $n { value = $input.nums|count }

    // lis[i] = length of longest increasing subsequence ending at index i
    var $lis { value = [] }
    // lds[i] = length of longest decreasing subsequence starting at index i
    // (or LIS from right to left)
    var $lds { value = [] }

    var $i { value = 0 }

    // Initialize LIS and LDS arrays with 1s
    while ($i < $n) {
      each {
        var $lis { value = $lis|merge:[1] }
        var $lds { value = $lds|merge:[1] }
        var.update $i { value = $i + 1 }
      }
    }

    // Compute LIS from left to right
    // For each element, check all previous elements
    var $i { value = 1 }
    while ($i < $n) {
      each {
        var $j { value = 0 }
        while ($j < $i) {
          each {
            var $num_i { value = $input.nums|index:$i }
            var $num_j { value = $input.nums|index:$j }

            conditional {
              // If nums[j] < nums[i], we can extend the increasing subsequence
              if ($num_j < $num_i) {
                var $current_lis_i { value = $lis|index:$i }
                var $lis_j_plus_one { value = ($lis|index:$j) + 1 }

                conditional {
                  if ($lis_j_plus_one > $current_lis_i) {
                    var $before { value = $lis|slice:0:$i }
                    var $after { value = $lis|slice:($i + 1) }
                    var $lis {
                      value = $before|merge:[$lis_j_plus_one]|merge:$after
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

    // Compute LDS from right to left
    // For each element, check all elements to its right
    var $i { value = $n - 2 }
    while ($i >= 0) {
      each {
        var $j { value = $n - 1 }
        while ($j > $i) {
          each {
            var $num_i { value = $input.nums|index:$i }
            var $num_j { value = $input.nums|index:$j }

            conditional {
              // If nums[j] < nums[i], we can extend the decreasing subsequence
              // (going from right to left, so nums[i] > nums[j] means decreasing)
              if ($num_j < $num_i) {
                var $current_lds_i { value = $lds|index:$i }
                var $lds_j_plus_one { value = ($lds|index:$j) + 1 }

                conditional {
                  if ($lds_j_plus_one > $current_lds_i) {
                    var $before { value = $lds|slice:0:$i }
                    var $after { value = $lds|slice:($i + 1) }
                    var $lds {
                      value = $before|merge:[$lds_j_plus_one]|merge:$after
                    }
                  }
                }
              }
            }

            var.update $j { value = $j - 1 }
          }
        }
        var.update $i { value = $i - 1 }
      }
    }

    // Find the maximum bitonic length
    // For each position, the bitonic length = lis[i] + lds[i] - 1
    // (subtract 1 because the peak element is counted twice)
    var $max_bitonic { value = 1 }
    var $k { value = 0 }

    while ($k < $n) {
      each {
        var $lis_k { value = $lis|index:$k }
        var $lds_k { value = $lds|index:$k }
        var $bitonic_length { value = $lis_k + $lds_k - 1 }

        conditional {
          if ($bitonic_length > $max_bitonic) {
            var.update $max_bitonic { value = $bitonic_length }
          }
        }
        var.update $k { value = $k + 1 }
      }
    }
  }

  response = $max_bitonic
}
