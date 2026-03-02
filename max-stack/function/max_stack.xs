// Max Stack - Design a stack that supports push, pop, top, and getMax in O(1) time
// This implementation uses two stacks: one for values, one for maximums
function "max_stack" {
  description = "Implements a Max Stack that returns results for a sequence of operations"
  
  input {
    // Array of operations to perform: "push", "pop", "top", "getMax"
    text[] operations { description = "Array of operation names: push, pop, top, getMax" }
    // Array of values corresponding to operations (null for pop, top, getMax)
    int[]? values { description = "Array of values for push operations, null for others" }
  }
  
  stack {
    // Main stack to store all values
    var $stack { value = [] }
    // Max stack to track maximums - top is always current maximum
    var $max_stack { value = [] }
    // Results array to store outputs from top and getMax operations
    var $results { value = [] }
    // Index for iterating through operations
    var $i { value = 0 }
    
    while ($i < ($input.operations|count)) {
      each {
        var $op { value = $input.operations[$i] }
        var $val { value = ($input.values != null) ? $input.values[$i] : null }
        
        conditional {
          // Push operation: add to main stack and update max stack if needed
          if ($op == "push") {
            // Push to main stack
            var $stack { value = $stack|merge:[$val] }
            
            // Push to max stack if empty or value >= current max
            conditional {
              if (($max_stack|count) == 0) {
                var $max_stack { value = $max_stack|merge:[$val] }
              }
              elseif ($val >= ($max_stack|last)) {
                var $max_stack { value = $max_stack|merge:[$val] }
              }
            }
            
            // No output for push
            var $results { value = $results|merge:[null] }
          }
          // Pop operation: remove from main stack and max stack if needed
          elseif ($op == "pop") {
            conditional {
              if (($stack|count) > 0) {
                // Get the top value before popping
                var $top_val { value = $stack|last }
                
                // Pop from main stack by creating new array without last element
                var $new_stack { value = [] }
                var $j { value = 0 }
                while ($j < (($stack|count) - 1)) {
                  each {
                    var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                    var.update $j { value = $j + 1 }
                  }
                }
                var $stack { value = $new_stack }
                
                // If popped value equals current max, pop from max stack too
                conditional {
                  if ($top_val == ($max_stack|last)) {
                    var $new_max_stack { value = [] }
                    var $k { value = 0 }
                    while ($k < (($max_stack|count) - 1)) {
                      each {
                        var $new_max_stack { value = $new_max_stack|merge:[$max_stack[$k]] }
                        var.update $k { value = $k + 1 }
                      }
                    }
                    var $max_stack { value = $new_max_stack }
                  }
                }
              }
            }
            
            // No output for pop
            var $results { value = $results|merge:[null] }
          }
          // Top operation: return top element without removing
          elseif ($op == "top") {
            conditional {
              if (($stack|count) > 0) {
                var $top_val { value = $stack|last }
                var $results { value = $results|merge:[$top_val] }
              }
              else {
                var $results { value = $results|merge:[null] }
              }
            }
          }
          // GetMax operation: return current maximum
          elseif ($op == "getMax") {
            conditional {
              if (($max_stack|count) > 0) {
                var $current_max { value = $max_stack|last }
                var $results { value = $results|merge:[$current_max] }
              }
              else {
                var $results { value = $results|merge:[null] }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $results
}
