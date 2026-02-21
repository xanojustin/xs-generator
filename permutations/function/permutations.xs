// Permutations - Classic backtracking exercise
// Given an array of distinct integers, return all possible permutations
function "permutations" {
  description = "Generate all permutations of a given array of distinct integers"
  
  input {
    int[] nums { description = "Array of distinct integers to permute" }
  }
  
  stack {
    // Result array to store all permutations
    var $result { value = [] }
    
    // Current permutation being built
    var $current { value = [] }
    
    // Boolean array to track which elements are used
    // We'll use a JSON object with indices as keys
    var $used { value = {} }
    
    // Initialize used tracking object
    var $i { value = 0 }
    while ($i < $input.nums|count) {
      each {
        var $used {
          value = $used|set:($i|to_text):false
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Backtracking helper function implemented as a block
    // We'll use iteration with a manual stack to simulate recursion
    var $stack { value = [] }
    
    // Initialize with starting state (current permutation, used tracking)
    // Using a stack of states: [current_permutation, used_map, start_index]
    var $stack {
      value = [
        {
          current: [],
          used: $used
        }
      ]
    }
    
    // While stack is not empty
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $state { value = $stack|last }
        var $stack {
          value = $stack|slice:0:-1
        }
        
        var $curr_perm { value = $state|get:"current" }
        var $curr_used { value = $state|get:"used" }
        
        // If current permutation is complete (same length as input)
        conditional {
          if (($curr_perm|count) == ($input.nums|count)) {
            // Add to result
            var $result {
              value = $result|merge:[$curr_perm]
            }
          }
          else {
            // Try each number that hasn't been used
            var $idx { value = 0 }
            while ($idx < $input.nums|count) {
              each {
                var $idx_key { value = $idx|to_text }
                var $is_used { value = $curr_used|get:$idx_key }
                
                conditional {
                  if (!$is_used) {
                    // Create new state with current number added
                    var $new_perm {
                      value = $curr_perm|merge:[$input.nums[$idx]]
                    }
                    var $new_used {
                      value = $curr_used|set:$idx_key:true
                    }
                    
                    // Push to stack
                    var $new_state {
                      value = {
                        current: $new_perm,
                        used: $new_used
                      }
                    }
                    var $stack {
                      value = $stack|merge:[$new_state]
                    }
                  }
                }
                
                var.update $idx { value = $idx + 1 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $result
}
