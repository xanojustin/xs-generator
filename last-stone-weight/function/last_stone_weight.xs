function "last_stone_weight" {
  description = "Find the weight of the last remaining stone after smashing"
  input {
    int[] stones
  }
  stack {
    // Initialize heap array from input
    var $heap {
      value = $input.stones
    }
    
    // Process stones until at most one remains
    while (($heap|count) > 1) {
      each {
        // Find the heaviest stone (max value)
        var $max1 { value = 0 }
        var $max1_idx { value = 0 }
        var $idx { value = 0 }
        
        foreach ($heap) {
          each as $stone {
            conditional {
              if ($stone > $max1) {
                var.update $max1 { value = $stone }
                var.update $max1_idx { value = $idx }
              }
            }
            var.update $idx { value = $idx + 1 }
          }
        }
        
        // Remove the first max from heap
        var $heap_without_first {
          value = ($heap|slice:0:$max1_idx)|merge:($heap|slice:($max1_idx + 1):(($heap|count) - $max1_idx - 1))
        }
        
        // Find the second heaviest stone
        var $max2 { value = 0 }
        var $max2_idx { value = 0 }
        var $idx2 { value = 0 }
        
        foreach ($heap_without_first) {
          each as $stone {
            conditional {
              if ($stone > $max2) {
                var.update $max2 { value = $stone }
                var.update $max2_idx { value = $idx2 }
              }
            }
            var.update $idx2 { value = $idx2 + 1 }
          }
        }
        
        // Remove the second max from heap
        var $new_heap {
          value = ($heap_without_first|slice:0:$max2_idx)|merge:($heap_without_first|slice:($max2_idx + 1):(($heap_without_first|count) - $max2_idx - 1))
        }
        
        // Calculate result of smash
        conditional {
          if ($max1 == $max2) {
            // Both stones destroyed, heap already updated
            var.update $heap { value = $new_heap }
          }
          else {
            // Add the difference back to heap
            var.update $heap { value = $new_heap|push:($max1 - $max2) }
          }
        }
      }
    }
    
    // Return the last stone weight or 0
    conditional {
      if (($heap|count) == 0) {
        var $result { value = 0 }
      }
      else {
        var $result { value = $heap|first }
      }
    }
  }
  response = $result
}
