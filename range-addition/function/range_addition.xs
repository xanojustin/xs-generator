function "range_addition" {
  description = "Increment elements of an array based on range updates using difference array technique"
  input {
    int length { description = "Length of the array" }
    json updates { description = "Array of updates [startIdx, endIdx, inc]" }
  }
  stack {
    // Initialize difference array with zeros
    var $diff_array { value = (1..$input.length)|map:0 }
    
    // Apply difference array technique
    foreach ($input.updates) {
      each as $update {
        var $start { value = $update[0] }
        var $end { value = $update[1] }
        var $inc { value = $update[2] }
        
        // Rebuild array with updated start value
        var $new_diff { value = [] }
        var $idx { value = 0 }
        foreach ($diff_array) {
          each as $val {
            conditional {
              if ($idx == $start) {
                var $new_diff { value = $new_diff|append:($val + $inc) }
              }
              else {
                var $new_diff { value = $new_diff|append:$val }
              }
            }
            var $idx { value = $idx + 1 }
          }
        }
        var $diff_array { value = $new_diff }
        
        // Subtract increment at end+1 index (if within bounds)
        conditional {
          if ($end + 1 < $input.length) {
            var $new_diff2 { value = [] }
            var $idx2 { value = 0 }
            foreach ($diff_array) {
              each as $val2 {
                conditional {
                  if ($idx2 == $end + 1) {
                    var $new_diff2 { value = $new_diff2|append:($val2 - $inc) }
                  }
                  else {
                    var $new_diff2 { value = $new_diff2|append:$val2 }
                  }
                }
                var $idx2 { value = $idx2 + 1 }
              }
            }
            var $diff_array { value = $new_diff2 }
          }
        }
      }
    }
    
    // Compute prefix sum to get final values
    var $prefix_sum { value = 0 }
    var $final_array { value = [] }
    foreach ($diff_array) {
      each as $val {
        var $prefix_sum { value = $prefix_sum + $val }
        var $final_array { value = $final_array|append:$prefix_sum }
      }
    }
  }
  response = $final_array
}
