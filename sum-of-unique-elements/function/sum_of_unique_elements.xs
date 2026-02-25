function "sum_of_unique_elements" {
  description = "Returns the sum of all elements that appear exactly once in the array"
  input {
    int[] nums
  }
  stack {
    // Handle empty array case
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Build frequency count using an object
    var $freq { value = {} }
    
    foreach ($input.nums) {
      each as $num {
        var $num_key { value = $num|to_text }
        conditional {
          if ($freq|has:$num_key) {
            // Increment existing count
            var $current_count { value = $freq|get:$num_key }
            var.update $freq {
              value = $freq|set:$num_key:($current_count + 1)
            }
          }
          else {
            // First occurrence - initialize count to 1
            var.update $freq {
              value = $freq|set:$num_key:1
            }
          }
        }
      }
    }
    
    // Sum elements that appear exactly once
    var $sum { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        var $num_key { value = $num|to_text }
        var $count { value = $freq|get:$num_key }
        conditional {
          if ($count == 1) {
            var.update $sum { value = $sum + $num }
          }
        }
      }
    }
  }
  response = $sum
}
