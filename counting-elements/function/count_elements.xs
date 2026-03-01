function "count_elements" {
  description = "Count elements x such that x+1 also exists in the array"
  input {
    int[] nums
  }
  stack {
    // Handle empty array edge case
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }

    // Create a set of all elements for O(1) lookup
    var $element_set { value = {} }
    foreach ($input.nums) {
      each as $num {
        var.update $element_set { value = $element_set|set:($num|to_text):true }
      }
    }

    // Count elements where x+1 exists in the set
    var $count { value = 0 }
    foreach ($input.nums) {
      each as $num {
        var $next_num { value = $num + 1 }
        var $next_key { value = $next_num|to_text }
        var $exists { value = $element_set|has:$next_key }
        conditional {
          if ($exists) {
            var.update $count { value = $count + 1 }
          }
        }
      }
    }
  }
  response = $count
}
