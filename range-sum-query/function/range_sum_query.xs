function "range_sum_query" {
  description = "Calculate the sum of elements between indices left and right (inclusive) using prefix sums"
  input {
    int[] nums { description = "The immutable integer array" }
    int left filters=min:0 { description = "Starting index (inclusive)" }
    int right filters=min:0 { description = "Ending index (inclusive)" }
  }
  stack {
    // Validate that left <= right
    precondition ($input.left <= $input.right) {
      error_type = "inputerror"
      error = "left index must be less than or equal to right index"
    }
    
    // Validate that indices are within bounds
    var $n { value = $input.nums|count }
    precondition ($input.right < $n) {
      error_type = "inputerror"
      error = "right index is out of bounds"
    }
    
    // Build prefix sum array where prefix[i] = sum of nums[0..i-1]
    // prefix[0] = 0, prefix[1] = nums[0], prefix[2] = nums[0] + nums[1], etc.
    var $prefix { value = [0] }
    var $running_sum { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        math.add $running_sum { value = $num }
        array.push $prefix { value = $running_sum }
      }
    }
    
    // Calculate range sum: prefix[right+1] - prefix[left]
    // This gives us sum of nums[left..right]
    var $left_sum { value = $prefix|get:$input.left }
    var $right_sum { value = $prefix|get:($input.right + 1) }
    var $range_sum { value = $right_sum - $left_sum }
  }
  response = $range_sum
}
