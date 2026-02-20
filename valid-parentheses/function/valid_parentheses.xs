// Valid Parentheses - Classic stack-based interview problem
// Determines if a string of brackets is valid (properly opened and closed)
function "valid_parentheses" {
  description = "Checks if a string of brackets is valid using a stack"
  
  input {
    text s { description = "String containing only brackets: (){}[]" }
  }
  
  stack {
    // Stack to track opening brackets
    var $stack { value = [] }
    
    // Mapping of closing to opening brackets
    var $pairs { 
      value = {
        ")": "(",
        "}": "{",
        "]": "["
      }
    }
    
    // Process each character in the string
    var $chars { value = $input.s|split:"" }
    var $is_valid { value = true }
    var $i { value = 0 }
    
    while (($i < ($chars|count)) && $is_valid) {
      each {
        var $char { value = $chars[$i] }
        
        conditional {
          // If it's an opening bracket, push to stack
          if (($char == "(") || ($char == "{") || ($char == "[")) {
            var $stack { value = $stack|merge:[$char] }
          }
          // If it's a closing bracket, check for match
          elseif (($char == ")") || ($char == "}") || ($char == "]")) {
            conditional {
              // Stack empty means no matching opening bracket
              if (($stack|count) == 0) {
                var $is_valid { value = false }
              }
              else {
                // Check if top of stack matches expected opening bracket
                var $top { value = $stack|last }
                var $expected { value = $pairs[$char] }
                
                conditional {
                  if ($top != $expected) {
                    var $is_valid { value = false }
                  }
                  else {
                    // Pop from stack - create new array without last element
                    var $new_stack { value = [] }
                    var $j { value = 0 }
                    while ($j < (($stack|count) - 1)) {
                      each {
                        var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                        var.update $j { value = $j + 1 }
                      }
                    }
                    var $stack { value = $new_stack }
                  }
                }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Valid only if stack is empty (all brackets matched)
    conditional {
      if (($stack|count) > 0) {
        var $is_valid { value = false }
      }
    }
  }
  
  response = $is_valid
}
