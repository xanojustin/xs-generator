function "subarray_product_less_than_k" {
  description = "Count contiguous subarrays with product strictly less than k"

  input {
    int[] nums { description = "Array of positive integers" }
    int k { description = "Product threshold" }
  }

  stack {
    // Edge case: if k <= 1, no subarray can have product < k (since all nums are >= 1)
    conditional {
      if (`$input.k <= 1`) {
        return { value = 0 }
      }
    }

    // Edge case: empty array
    conditional {
      if (`($input.nums|count) == 0`) {
        return { value = 0 }
      }
    }

    // Initialize variables for sliding window
    var $count { value = 0 }
    var $product { value = 1 }
    var $left { value = 0 }
    var $n { value = $input.nums|count }

    // Iterate through array with right pointer
    for ($n) {
      each as $right {
        // Multiply current number into product
        var $current_num { value = $input.nums|get:$right }
        var.update $product { value = $product * $current_num }

        // Shrink window from left while product >= k
        while (`$product >= $input.k && $left <= $right`) {
          each {
            var $left_num { value = $input.nums|get:$left }
            var.update $product { value = $product / $left_num }
            var.update $left { value = $left + 1 }
          }
        }

        // Add count of valid subarrays ending at current right
        // All subarrays with start in [left, right] and end at right are valid
        var.update $count { value = $count + ($right - $left + 1) }
      }
    }
  }

  response = $count
}
