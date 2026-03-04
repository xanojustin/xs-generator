function "find_set_mismatch" {
  description = "Find the duplicated and missing numbers in a set of integers from 1 to n"
  input {
    int[] nums { description = "Array of integers containing one duplicate and one missing number" }
  }
  stack {
    var $n { value = ($input.nums|count) }
    var $freq { value = {} }
    var $duplicate { value = 0 }
    var $missing { value = 0 }
    
    // Build frequency map and find duplicate
    foreach ($input.nums) {
      each as $num {
        var $num_str { value = $num|to_text }
        var $current_count { value = ($freq|get:$num_str)|to_int }
        conditional {
          if ($current_count == 1) {
            var $duplicate { value = $num }
          }
        }
        var.update $freq { value = $freq|set:$num_str:($current_count + 1) }
      }
    }
    
    // Find missing number by checking 1 to n
    for ($n) {
      each as $i {
        var $val { value = $i + 1 }
        var $val_str { value = $val|to_text }
        var $count { value = ($freq|get:$val_str)|to_int }
        conditional {
          if ($count == 0) {
            var $missing { value = $val }
          }
        }
      }
    }
  }
  response = [$duplicate, $missing]
}
