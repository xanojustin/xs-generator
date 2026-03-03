function "increasing_triplet_subsequence" {
  description = "Determine if there exists a triple of indices (i, j, k) such that i < j < k and nums[i] < nums[j] < nums[k]"
  input {
    int[] nums
  }
  stack {
    // Edge case: need at least 3 elements for a triplet
    var $length {
      value = ($input.nums|count)
    }
    
    conditional {
      if ($length < 3) {
        return { value = false }
      }
    }

    // O(n) solution using two variables
    // first = smallest number seen so far
    // second = smallest number that has a smaller number before it
    var $first {
      value = 2147483647
    }
    var $second {
      value = 2147483647
    }

    foreach ($input.nums) {
      each as $num {
        conditional {
          // If current number is smaller than or equal to first, update first
          if ($num <= $first) {
            var $first { value = $num }
          }
          // If current number is smaller than or equal to second (but greater than first), update second
          elseif ($num <= $second) {
            var $second { value = $num }
          }
          // If current number is greater than both first and second, we found a triplet
          else {
            return { value = true }
          }
        }
      }
    }

    // No triplet found
    return { value = false }
  }
  response = false
}
