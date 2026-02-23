function "decode_string" {
  description = "Decodes an encoded string with pattern k[encoded_string]. Returns the decoded string."
  
  input {
    text encoded
  }
  
  stack {
    // Stack to hold characters and previous strings
    var $stack { value = [] }
    
    // Current number being built (for multi-digit numbers)
    var $current_num { value = 0 }
    
    // Current string being built
    var $current_str { value = "" }
    
    // Index for iterating through the string
    var $i { value = 0 }
    
    while ($i < ($input.encoded|strlen)) {
      each {
        // Get current character
        var $char { value = $input.encoded|slice:$i:($i + 1) }
        
        conditional {
          // If digit, build the number
          if ($char >= "0" && $char <= "9") {
            var.update $current_num { 
              value = ($current_num * 10) + ($char|to_int) 
            }
          }
          // If opening bracket, push current state to stack
          elseif ($char == "[") {
            // Push current string and number to stack
            var.update $stack { 
              value = $stack|append:$current_str 
            }
            var.update $stack { 
              value = $stack|append:$current_num 
            }
            // Reset for inner context
            var.update $current_str { value = "" }
            var.update $current_num { value = 0 }
          }
          // If closing bracket, pop and decode
          elseif ($char == "]") {
            // Pop the number (repeat count)
            var $repeat_count { value = $stack|last }
            var.update $stack { value = $stack|slice:0:(($stack|count) - 1) }
            
            // Pop the previous string
            var $prev_str { value = $stack|last }
            var.update $stack { value = $stack|slice:0:(($stack|count) - 1) }
            
            // Build repeated string
            var $repeated { value = "" }
            var $j { value = 0 }
            while ($j < $repeat_count) {
              each {
                var.update $repeated { value = $repeated ~ $current_str }
                var.update $j { value = $j + 1 }
              }
            }
            
            // Combine with previous string
            var.update $current_str { value = $prev_str ~ $repeated }
          }
          // Regular character, add to current string
          else {
            var.update $current_str { value = $current_str ~ $char }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $current_str
}
