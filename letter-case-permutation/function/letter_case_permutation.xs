// Letter Case Permutation - Backtracking exercise
// Given a string S, we can transform every letter individually to be lowercase or uppercase
// to create another string. Return a list of all possible strings we could create.
function "letter_case_permutation" {
  description = "Generate all possible strings by changing the case of every letter in the input string"
  
  input {
    text s { description = "Input string containing letters and/or digits" }
  }
  
  stack {
    // Result array to store all permutations
    var $result { value = [] }
    
    // Convert input string to array of characters for easier manipulation
    var $chars { value = [] }
    var $i { value = 0 }
    while ($i < ($input.s|strlen)) {
      each {
        var $char { value = $input.s|substr:$i:$i+1 }
        var $chars {
          value = $chars|merge:[$char]
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Identify which positions contain letters (not digits)
    // We'll use an array of booleans to track letter positions
    var $letter_positions { value = [] }
    var $j { value = 0 }
    while ($j < ($chars|count)) {
      each {
        var $ch { value = $chars[$j] }
        // Check if character is a letter (a-z or A-Z)
        // Compare with lowercase and uppercase versions
        var $is_letter {
          value = ($ch >= "a" && $ch <= "z") || ($ch >= "A" && $ch <= "Z")
        }
        var $letter_positions {
          value = $letter_positions|merge:[$is_letter]
        }
        var.update $j { value = $j + 1 }
      }
    }
    
    // Count total letters (for early return if no letters)
    var $letter_count { value = 0 }
    var $k { value = 0 }
    while ($k < ($letter_positions|count)) {
      each {
        conditional {
          if ($letter_positions[$k]) {
            var.update $letter_count { value = $letter_count + 1 }
          }
        }
        var.update $k { value = $k + 1 }
      }
    }
    
    // If no letters, just return the original string
    conditional {
      if ($letter_count == 0) {
        var $result { value = [$input.s] }
      }
      else {
        // Use iterative backtracking with a stack
        // Each stack item contains: current_string, current_position
        var $stack { value = [] }
        
        // Initialize with empty string at position 0
        var $stack {
          value = [
            {
              current: "",
              pos: 0
            }
          ]
        }
        
        // Process stack until empty
        while (($stack|count) > 0) {
          each {
            // Pop from stack
            var $state { value = $stack|last }
            var $stack {
              value = $stack|slice:0:-1
            }
            
            var $curr_str { value = $state|get:"current" }
            var $pos { value = $state|get:"pos" }
            
            // If we've processed all characters, add to result
            conditional {
              if ($pos >= ($chars|count)) {
                var $result {
                  value = $result|merge:[$curr_str]
                }
              }
              else {
                var $curr_char { value = $chars[$pos] }
                var $is_curr_letter { value = $letter_positions[$pos] }
                
                conditional {
                  if (!$is_curr_letter) {
                    // Digit - just append and continue
                    var $new_state {
                      value = {
                        current: ($curr_str ~ $curr_char),
                        pos: $pos + 1
                      }
                    }
                    var $stack {
                      value = $stack|merge:[$new_state]
                    }
                  }
                  else {
                    // Letter - branch into lowercase and uppercase
                    
                    // Lowercase version
                    var $lower_char { value = $curr_char|to_lower }
                    var $lower_state {
                      value = {
                        current: ($curr_str ~ $lower_char),
                        pos: $pos + 1
                      }
                    }
                    var $stack {
                      value = $stack|merge:[$lower_state]
                    }
                    
                    // Uppercase version
                    var $upper_char { value = $curr_char|to_upper }
                    var $upper_state {
                      value = {
                        current: ($curr_str ~ $upper_char),
                        pos: $pos + 1
                      }
                    }
                    var $stack {
                      value = $stack|merge:[$upper_state]
                    }
                  }
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
