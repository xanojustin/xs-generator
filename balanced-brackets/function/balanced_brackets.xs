function "balanced_brackets" {
  description = "Check if a string of brackets is balanced"
  input {
    text brackets { description = "String containing only bracket characters (){}[]" }
  }
  stack {
    // Stack to track opening brackets
    var $stack { value = [] }
    
    // Process each character in the input string
    foreach ($input.brackets|split:"") {
      each as $char {
        conditional {
          // Opening brackets - push to stack
          if ($char == "(" || $char == "{" || $char == "[") {
            var $stack { value = $stack|push:$char }
          }
          // Closing brackets - check for match
          elseif ($char == ")" || $char == "}" || $char == "]") {
            // Check if stack is empty (no matching opening bracket)
            conditional {
              if (($stack|count) == 0) {
                return { value = false }
              }
            }
            
            // Get the top of the stack
            var $top { value = $stack|last }
            
            // Check if brackets match
            var $is_match { value = false }
            conditional {
              if ($char == ")" && $top == "(") {
                var.update $is_match { value = true }
              }
              elseif ($char == "}" && $top == "{") {
                var.update $is_match { value = true }
              }
              elseif ($char == "]" && $top == "[") {
                var.update $is_match { value = true }
              }
            }
            
            conditional {
              if ($is_match) {
                // Pop the opening bracket from stack
                var $stack { value = $stack|pop }
              }
              else {
                // Mismatched brackets
                return { value = false }
              }
            }
          }
        }
      }
    }
    
    // Check if stack is empty (all brackets matched)
    var $is_balanced { value = ($stack|count) == 0 }
  }
  response = $is_balanced
}
