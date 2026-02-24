// Range Sum Query - Prefix Sum implementation
// Given an array of integers, efficiently compute the sum of elements
// between indices left and right (inclusive)
function "range_sum_query" {
  description = "Computes range sum queries using prefix sum array"

  input {
    int[] nums { description = "Array of integers" }
    int left { description = "Left index (inclusive)" }
    int right { description = "Right index (inclusive)" }
  }

  stack {
    // Build prefix sum array where prefix[i] = sum of nums[0..i-1]
    var $prefix { value = [0] }
    var $n { value = $input.nums|count }
    var $i { value = 0 }

    // Compute prefix sums: prefix[i+1] = prefix[i] + nums[i]
    while ($i < $n) {
      each {
        var $prefix_len { value = ($prefix|count) - 1 }
        var $last_prefix { value = $prefix[$prefix_len] }
        var $current_sum { value = $last_prefix + $input.nums[$i] }
        array.push $prefix {
          value = $current_sum
        }
        math.add $i { value = 1 }
      }
    }

    // Calculate range sum using prefix array
    // Sum from left to right = prefix[right+1] - prefix[left]
    var $range_sum { value = $prefix[$input.right + 1] - $prefix[$input.left] }
  }

  response = $range_sum
}
