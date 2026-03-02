function "minimum_remove_to_make_valid_parentheses" {
  description = "Remove the minimum number of parentheses to make the string valid"
  input {
    text s { description = "Input string containing parentheses and lowercase letters" }
  }
  stack {
    // Convert string to array for character manipulation
    var $chars { value = $input.s|split:"" }
    
    // Stack to track indices of unmatched opening parentheses
    var $stack { value = [] }
    
    // Set to track indices that need to be removed
    var $remove_indices { value = {} }
    
    // First pass: identify unmatched parentheses using stack
    var $i { value = 0 }
    while ($i < ($chars|count)) {
      each {
        var $char { value = $chars|get:$i }
        
        conditional {
          if ($char == "(") {
            // Push index onto stack
            var $stack {
              value = $stack|set:(($stack|count)|to_text):$i
            }
          }
          elseif ($char == ")") {
            conditional {
              if (($stack|count) > 0) {
                // Match found - pop from stack
                var $stack {
                  value = $stack|slice:0:(-1)
                }
              }
              else {
                // Unmatched closing parenthesis - mark for removal
                var $remove_indices {
                  value = $remove_indices|set:($i|to_text):true
                }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Any remaining indices in stack are unmatched opening parentheses
    foreach ($stack) {
      each as $idx {
        var $remove_indices {
          value = $remove_indices|set:($idx|to_text):true
        }
      }
    }
    
    // Build result string by including only non-removed characters
    var $result { value = "" }
    var $j { value = 0 }
    while ($j < ($chars|count)) {
      each {
        var $j_text { value = $j|to_text }
        conditional {
          if (!($remove_indices|has:$j_text)) {
            var $char { value = $chars|get:$j }
            var $result {
              value = $result ~ $char
            }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  response = $result
}
