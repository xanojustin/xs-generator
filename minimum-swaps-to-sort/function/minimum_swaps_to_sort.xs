function "minimum_swaps_to_sort" {
  input {
    int[] arr
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.arr|count) <= 1) {
        return { value = 0 }
      }
    }
    
    // Create array of pairs: [value, original_index]
    var $pairs { value = [] }
    var $i { value = 0 }
    
    foreach ($input.arr) {
      each as $val {
        var $pair {
          value = {
            value: $val,
            index: $i
          }
        }
        var.update $pairs { value = $pairs|append:$pair }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Sort pairs by value
    var $sorted_pairs {
      value = $pairs|sort:$$.value
    }
    
    // Track visited elements
    var $visited { value = [] }
    var $j { value = 0 }
    for (($input.arr|count)) {
      each as $idx {
        var.update $visited { value = $visited|append:false }
      }
    }
    
    // Count swaps using cycle detection
    var $swaps { value = 0 }
    var $idx { value = 0 }
    var $arr_count { value = ($input.arr|count) }
    
    while ($idx < $arr_count) {
      each {
        // Skip if already visited or already in correct position
        conditional {
          if ($visited[$idx] == true || ($sorted_pairs[$idx]|get:"index") == $idx) {
            var.update $idx { value = $idx + 1 }
          }
          else {
            // Find cycle size
            var $cycle_size { value = 0 }
            var $current { value = $idx }
            
            while ($visited[$current] == false) {
              each {
                var.update $visited { 
                  value = $visited|set:($current|to_text):true 
                }
                var.update $current {
                  value = $sorted_pairs[$current]|get:"index"
                }
                var.update $cycle_size { value = $cycle_size + 1 }
              }
            }
            
            // Add swaps needed for this cycle (cycle_size - 1)
            conditional {
              if ($cycle_size > 0) {
                var.update $swaps { value = $swaps + $cycle_size - 1 }
              }
            }
            
            var.update $idx { value = $idx + 1 }
          }
        }
      }
    }
  }
  
  response = $swaps
}
