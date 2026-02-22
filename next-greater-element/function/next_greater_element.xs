// Next Greater Element - Classic stack-based interview problem
// For each element in the array, finds the next element to its right that is greater.
// If no greater element exists, returns -1 for that position.
function "next_greater_element" {
  description = "Finds the next greater element for each element in an array"
  
  input {
    int[] nums { description = "Array of integers to find next greater elements for" }
  }
  
  stack {
    // Result array initialized with -1 (default when no greater element exists)
    var $result { value = [] }
    var $i { value = 0 }
    while ($i < ($input.nums|count)) {
      each {
        var $result { value = $result|merge:[-1] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Stack to store indices of elements waiting for their next greater element
    var $stack { value = [] }
    
    // Iterate through the array
    var $idx { value = 0 }
    while ($idx < ($input.nums|count)) {
      each {
        var $current_num { value = $input.nums[$idx] }
        
        // While stack is not empty and current element is greater than the element at stack top
        conditional {
          if (($stack|count) > 0) {
            var $continue_checking { value = true }
            while (($stack|count) > 0 && $continue_checking) {
              each {
                var $top_idx { value = $stack|last }
                var $top_num { value = $input.nums[$top_idx] }
                
                conditional {
                  if ($current_num > $top_num) {
                    // Found next greater element for the index at stack top
                    // Update result at top_idx with current number
                    var $new_result { value = [] }
                    var $j { value = 0 }
                    while ($j < ($result|count)) {
                      each {
                        conditional {
                          if ($j == $top_idx) {
                            var $new_result { value = $new_result|merge:[$current_num] }
                          }
                          else {
                            var $new_result { value = $new_result|merge:[$result[$j]] }
                          }
                        }
                        var.update $j { value = $j + 1 }
                      }
                    }
                    var $result { value = $new_result }
                    
                    // Pop from stack - remove the last element
                    var $new_stack { value = [] }
                    var $k { value = 0 }
                    while ($k < (($stack|count) - 1)) {
                      each {
                        var $new_stack { value = $new_stack|merge:[$stack[$k]] }
                        var.update $k { value = $k + 1 }
                      }
                    }
                    var $stack { value = $new_stack }
                  }
                  else {
                    // Current element is not greater, stop checking
                    var $continue_checking { value = false }
                  }
                }
              }
            }
          }
        }
        
        // Push current index onto stack
        var $stack { value = $stack|merge:[$idx] }
        
        var.update $idx { value = $idx + 1 }
      }
    }
  }
  
  response = $result
}
