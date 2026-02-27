// Score of Parentheses - Calculate score based on nested parentheses structure
// Rules: () = 1, AB = A+B (concatenation), (A) = 2*A (nesting)
function "score_of_parentheses" {
  description = "Calculates the score of a balanced parentheses string"
  
  input {
    text s { description = "A balanced parentheses string containing only '(' and ')'" }
  }
  
  stack {
    // Stack to store scores at each depth level
    var $stack { value = [0] }
    // Index for iterating through characters
    var $i { value = 0 }
    // Current depth/index in stack
    var $depth { value = 0 }
    
    while ($i < ($input.s|strlen)) {
      each {
        var $char { value = $input.s|substr:$i:1 }
        
        conditional {
          // Opening parenthesis - go deeper, start new score level
          if ($char == "(") {
            var $depth { value = $depth + 1 }
            // Push a new score level (0) onto the stack
            var $stack { value = $stack|merge:[0] }
          }
          // Closing parenthesis - calculate score for this level
          else {
            // Get the score at current depth
            var $current_score { value = $stack[$depth] }
            
            // Rule: () = 1, (A) = 2*A
            // If current score is 0, it means we saw "()", so score is 1
            // Otherwise, it's "(A)" where A has some score, so 2*A
            conditional {
              if ($current_score == 0) {
                var $current_score { value = 1 }
              }
              else {
                var $current_score { value = $current_score * 2 }
              }
            }
            
            // Pop current level and go back up
            var $depth { value = $depth - 1 }
            
            // Add current score to the level below (accumulate)
            // We need to rebuild the stack with the updated value at depth
            var $new_stack { value = [] }
            var $j { value = 0 }
            while ($j <= $depth) {
              each {
                conditional {
                  if ($j == $depth) {
                    // Add current score to this level
                    var $new_val { value = $stack[$j] + $current_score }
                    var $new_stack { value = $new_stack|merge:[$new_val] }
                  }
                  else {
                    var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            var $stack { value = $new_stack }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Final result is at the bottom of the stack (index 0)
    var $result { value = $stack[0] }
  }
  
  response = $result
}
