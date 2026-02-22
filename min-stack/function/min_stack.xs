// Min Stack - Design a stack that supports push, pop, top, and getMin in O(1) time
// This implementation uses two stacks: one for values, one for minimums
function "min_stack" {
  description = "Implements a Min Stack that returns results for a sequence of operations"
  
  input {
    // Array of operations to perform: "push", "pop", "top", "getMin"
    text[] operations { description = "Array of operation names: push, pop, top, getMin" }
    // Array of values corresponding to operations (null for pop, top, getMin)
    int[]? values { description = "Array of values for push operations, null for others" }
  }
  
  stack {
    // Main stack to store all values
    var $stack { value = [] }
    // Min stack to track minimums - top is always current minimum
    var $min_stack { value = [] }
    // Results array to store outputs from top and getMin operations
    var $results { value = [] }
    // Index for iterating through operations
    var $i { value = 0 }
    
    while ($i < ($input.operations|count)) {
      each {
        var $op { value = $input.operations[$i] }
        var $val { value = ($input.values != null) ? $input.values[$i] : null }
        
        conditional {
          // Push operation: add to main stack and update min stack if needed
          if ($op == "push") {
            // Push to main stack
            var $stack { value = $stack|merge:[$val] }
            
            // Push to min stack if empty or value <= current min
            conditional {
              if (($min_stack|count) == 0) {
                var $min_stack { value = $min_stack|merge:[$val] }
              }
              elseif ($val <= ($min_stack|last)) {
                var $min_stack { value = $min_stack|merge:[$val] }
              }
            }
            
            // No output for push
            var $results { value = $results|merge:[null] }
          }
          // Pop operation: remove from main stack and min stack if needed
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
                
                // If popped value equals current min, pop from min stack too
                conditional {
                  if ($top_val == ($min_stack|last)) {
                    var $new_min_stack { value = [] }
                    var $k { value = 0 }
                    while ($k < (($min_stack|count) - 1)) {
                      each {
                        var $new_min_stack { value = $new_min_stack|merge:[$min_stack[$k]] }
                        var.update $k { value = $k + 1 }
                      }
                    }
                    var $min_stack { value = $new_min_stack }
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
          // GetMin operation: return current minimum
          elseif ($op == "getMin") {
            conditional {
              if (($min_stack|count) > 0) {
                var $current_min { value = $min_stack|last }
                var $results { value = $results|merge:[$current_min] }
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
