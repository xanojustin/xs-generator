// Generate Parentheses - Classic backtracking exercise
// Given n pairs of parentheses, generate all combinations of well-formed parentheses
function "generate_parentheses" {
  description = "Generates all valid combinations of n pairs of parentheses using backtracking"
  
  input {
    int n { description = "Number of pairs of parentheses" }
  }
  
  stack {
    // Result array to store all valid combinations
    var $result { value = [] }
    
    // Helper function simulation using iteration with a stack
    // We'll use a manual stack to simulate recursion
    var $stack { value = [] }
    
    // Initialize with starting state: empty string, 0 open, 0 close
    var $stack { value = [{str: "", open: 0, close: 0}] }
    
    // While stack is not empty
    while (($stack|count) > 0) {
      each {
        // Pop from stack (get last element)
        var $current { value = $stack|last }
        var $stack { value = $stack|slice:0:-1 }
        
        // Extract values from current state
        var $current_str { value = $current.str }
        var $open_count { value = $current.open }
        var $close_count { value = $current.close }
        
        // If we have a complete valid combination, add to result
        conditional {
          if ($open_count == $input.n && $close_count == $input.n) {
            var $result { 
              value = $result|merge:[$current_str]
            }
          }
          else {
            // Can we add an open parenthesis?
            conditional {
              if ($open_count < $input.n) {
                var $stack {
                  value = $stack|merge:[{
                    str: $current_str ~ "(",
                    open: $open_count + 1,
                    close: $close_count
                  }]
                }
              }
            }
            
            // Can we add a close parenthesis?
            conditional {
              if ($close_count < $open_count) {
                var $stack {
                  value = $stack|merge:[{
                    str: $current_str ~ ")",
                    open: $open_count,
                    close: $close_count + 1
                  }]
                }
              }
            }
          }
        }
      }
    }
  }
  
  response = $result
}
