function "valid-parentheses" {
  description = "Check if a string of parentheses, brackets, and braces is valid"
  
  input {
    text brackets { 
      description = "String containing only ()[]{} characters" 
    }
  }
  
  stack {
    // Stack to track opening brackets
    var $stack { 
      value = [] 
    }
    
    // Index for iterating through the string
    var $index { 
      value = 0 
    }
    
    // Get the length of the input string
    var $length { 
      value = ($input.brackets|count) 
    }
    
    // Flag to track if brackets are valid
    var $is_valid { 
      value = true 
    }
    
    // Iterate through each character
    while ($index < $length && $is_valid == true) {
      each {
        // Get current character using substring
        var $char {
          value = ($input.brackets|slice:$index:($index + 1))
        }
        
        // Check if it's an opening bracket
        conditional {
          if (`$char == "("` || `$char == "["` || `$char == "{"`) {
            // Push to stack
            var $new_stack {
              value = $stack|merge:[$char]
            }
            var.update $stack { value = $new_stack }
          }
          // Check if it's a closing bracket
          elseif (`$char == ")"` || `$char == "]"` || `$char == "}"`) {
            // Check if stack is empty (no matching opening bracket)
            conditional {
              if (($stack|count) == 0) {
                var.update $is_valid { value = false }
              }
              else {
                // Get the top of the stack
                var $top {
                  value = ($stack|last)
                }
                
                // Check if brackets match
                conditional {
                  if ((`$char == ")"` && `$top == "("`) || (`$char == "]"` && `$top == "["`) || (`$char == "}"` && `$top == "{"`)) {
                    // Pop from stack by taking all but last element
                    var $stack_count {
                      value = ($stack|count)
                    }
                    var $popped_stack {
                      value = ($stack|slice:0:($stack_count - 1))
                    }
                    var.update $stack { value = $popped_stack }
                  }
                  else {
                    // Mismatched bracket
                    var.update $is_valid { value = false }
                  }
                }
              }
            }
          }
        }
        
        // Increment index
        var $next_index {
          value = $index + 1
        }
        var.update $index { value = $next_index }
      }
    }
    
    // Final check: valid only if stack is empty and no mismatches found
    conditional {
      if ($is_valid == true && ($stack|count) == 0) {
        var $result { value = true }
      }
      else {
        var $result { value = false }
      }
    }
  }
  
  response = $result
}
