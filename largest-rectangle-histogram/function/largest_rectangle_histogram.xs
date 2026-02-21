// Largest Rectangle in Histogram
// Given an array of integers representing histogram bar heights,
// find the largest rectangle area that can be formed
// Uses a monotonic stack approach for O(n) time complexity
function "largest_rectangle_histogram" {
  description = "Finds the largest rectangle area in a histogram"
  
  input {
    int[] heights { description = "Array of integers representing histogram bar heights" }
  }
  
  stack {
    // Stack to store indices of bars (maintains increasing heights)
    var $stack { value = [] }
    var $max_area { value = 0 }
    var $n { value = $input.heights|count }
    var $i { value = 0 }
    
    // Iterate through all bars plus one extra iteration to empty stack
    while ($i <= $n) {
      each {
        // Current height (0 when i == n to flush remaining stack)
        var $current_height {
          value = ($i < $n) ? $input.heights[$i] : 0
        }
        
        // While stack is not empty and current height is less than stack top
        var $stack_empty { value = (($stack|count) == 0) }
        var $should_pop {
          value = !$stack_empty && ($current_height < $input.heights[($stack|last)])
        }
        
        while ($should_pop) {
          each {
            // Pop the top
            var $top_idx { value = $stack|last }
            var $stack { value = $stack|slice:0:-1 }
            
            // Calculate width
            var $stack_empty_after_pop { value = (($stack|count) == 0) }
            var $width {
              value = $stack_empty_after_pop ? $i : ($i - ($stack|last) - 1)
            }
            
            // Calculate area with popped bar as the shortest bar
            var $height { value = $input.heights[$top_idx] }
            var $area { value = $height * $width }
            
            // Update max area
            conditional {
              if ($area > $max_area) {
                var $max_area { value = $area }
              }
            }
            
            // Recalculate should_pop condition
            var $stack_empty { value = (($stack|count) == 0) }
            var $should_pop {
              value = !$stack_empty && ($current_height < $input.heights[($stack|last)])
            }
          }
        }
        
        // Push current index to stack
        conditional {
          if ($i < $n) {
            var $stack {
              value = $stack|merge:[$i]
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $max_area
}
