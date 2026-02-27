// Heap Sort - Sorts an array using the heap sort algorithm
// Builds a max heap and repeatedly extracts the maximum element
function "heap_sort" {
  description = "Sorts an array of integers using heap sort algorithm"
  
  input {
    int[] numbers { description = "Array of integers to sort" }
  }
  
  stack {
    var $n { value = $input.numbers|count }
    
    // Handle empty or single element arrays (already sorted)
    conditional {
      if ($n <= 1) {
        return { value = $input.numbers }
      }
    }
    
    // Convert array to object with string keys for mutable access
    var $heap { value = {} }
    var $idx { value = 0 }
    while ($idx < $n) {
      each {
        var $heap {
          value = $heap|set:($idx|to_text):$input.numbers[$idx]
        }
        var.update $idx { value = $idx + 1 }
      }
    }
    
    // Build max heap - start from the last non-leaf node and heapify upwards
    var $i { value = (($n / 2)|floor) - 1 }
    
    while ($i >= 0) {
      each {
        // Heapify at index $i with heap size $n
        var $parent_idx { value = $i }
        var $continue_heapify { value = true }
        
        while ($continue_heapify) {
          each {
            var $current_idx { value = $parent_idx }
            var $largest { value = $current_idx }
            var $left_child { value = (2 * $current_idx) + 1 }
            var $right_child { value = (2 * $current_idx) + 2 }
            
            // Get values using object notation
            var $largest_val { value = $heap|get:($largest|to_text) }
            var $left_val { value = $heap|get:($left_child|to_text) }
            var $right_val { value = $heap|get:($right_child|to_text) }
            
            // Check if left child exists and is greater than parent
            conditional {
              if ($left_child < $n && $left_val > $largest_val) {
                var $largest { value = $left_child }
                var $largest_val { value = $left_val }
              }
            }
            
            // Check if right child exists and is greater than current largest
            conditional {
              if ($right_child < $n && $right_val > $largest_val) {
                var $largest { value = $right_child }
              }
            }
            
            // If largest is not the parent, swap and continue heapifying
            conditional {
              if ($largest != $current_idx) {
                // Swap elements in the heap object
                var $current_val { value = $heap|get:($current_idx|to_text) }
                var $largest_val_swap { value = $heap|get:($largest|to_text) }
                var $heap {
                  value = $heap|set:($current_idx|to_text):$largest_val_swap
                }
                var $heap {
                  value = $heap|set:($largest|to_text):$current_val
                }
                var $parent_idx { value = $largest }
              }
              else {
                var $continue_heapify { value = false }
              }
            }
          }
        }
        
        var.update $i { value = $i - 1 }
      }
    }
    
    // Extract elements from heap one by one
    var $heap_size { value = $n }
    
    while ($heap_size > 1) {
      each {
        // Get root (max) and last element values
        var $root_val { value = $heap|get:"0" }
        var $last_val { value = $heap|get:(($heap_size - 1)|to_text) }
        
        // Move current root (max) to the end
        var $heap {
          value = $heap|set:"0":$last_val
        }
        var $heap {
          value = $heap|set:(($heap_size - 1)|to_text):$root_val
        }
        
        // Reduce heap size
        var $heap_size { value = $heap_size - 1 }
        
        // Heapify the root with new heap size
        var $heapify_idx { value = 0 }
        var $continue_heapify { value = true }
        
        while ($continue_heapify) {
          each {
            var $current_idx { value = $heapify_idx }
            var $largest_idx { value = $current_idx }
            var $left_idx { value = (2 * $current_idx) + 1 }
            var $right_idx { value = (2 * $current_idx) + 2 }
            
            var $largest_val_h { value = $heap|get:($largest_idx|to_text) }
            var $left_val_h { value = $heap|get:($left_idx|to_text) }
            var $right_val_h { value = $heap|get:($right_idx|to_text) }
            
            conditional {
              if ($left_idx < $heap_size && $left_val_h > $largest_val_h) {
                var $largest_idx { value = $left_idx }
                var $largest_val_h { value = $left_val_h }
              }
            }
            
            conditional {
              if ($right_idx < $heap_size && $right_val_h > $largest_val_h) {
                var $largest_idx { value = $right_idx }
              }
            }
            
            conditional {
              if ($largest_idx != $current_idx) {
                var $current_val_h { value = $heap|get:($current_idx|to_text) }
                var $largest_val_h_swap { value = $heap|get:($largest_idx|to_text) }
                var $heap {
                  value = $heap|set:($current_idx|to_text):$largest_val_h_swap
                }
                var $heap {
                  value = $heap|set:($largest_idx|to_text):$current_val_h
                }
                var $heapify_idx { value = $largest_idx }
              }
              else {
                var $continue_heapify { value = false }
              }
            }
          }
        }
      }
    }
    
    // Convert object back to array
    var $result { value = [] }
    var $j { value = 0 }
    while ($j < $n) {
      each {
        var $val { value = $heap|get:($j|to_text) }
        var $result {
          value = $result|push:$val
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  
  response = $result
}
