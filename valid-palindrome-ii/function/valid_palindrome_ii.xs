function "valid_palindrome_ii" {
  description = "Check if a string can be a palindrome by deleting at most one character"
  input {
    text s filters=trim { description = "The input string to check" }
  }
  stack {
    // Edge cases - empty string or single character is always a palindrome
    var $len { value = $input.s|strlen }
    conditional {
      if ($len <= 1) {
        return { value = true }
      }
    }
    
    // Helper to check if range is palindrome - implemented inline
    var $can_delete { value = true }
    var $left { value = 0 }
    var $right { value = $len - 1 }
    var $result { value = true }
    
    while (($left < $right) && $result) {
      each {
        var $left_char { 
          value = $input.s|substr:$left:1 
        }
        var $right_char { 
          value = $input.s|substr:$right:1 
        }
        
        conditional {
          if ($left_char == $right_char) {
            // Characters match, move both pointers inward
            var $left { value = $left + 1 }
            var $right { value = $right - 1 }
          }
          else {
            // Mismatch found
            conditional {
              if (!$can_delete) {
                // Already used our one deletion, not a valid palindrome
                var $result { value = false }
              }
              else {
                // Try skipping left character - check if s[left+1..right] is palindrome
                var $skip_left_l { value = $left + 1 }
                var $skip_left_r { value = $right }
                var $skip_left_ok { value = true }
                
                while (($skip_left_l < $skip_left_r) && $skip_left_ok) {
                  each {
                    var $sl_char { 
                      value = $input.s|substr:$skip_left_l:1 
                    }
                    var $sr_char { 
                      value = $input.s|substr:$skip_left_r:1 
                    }
                    conditional {
                      if ($sl_char != $sr_char) {
                        var $skip_left_ok { value = false }
                      }
                    }
                    var $skip_left_l { value = $skip_left_l + 1 }
                    var $skip_left_r { value = $skip_left_r - 1 }
                  }
                }
                
                // Try skipping right character - check if s[left..right-1] is palindrome
                var $skip_right_l { value = $left }
                var $skip_right_r { value = $right - 1 }
                var $skip_right_ok { value = true }
                
                while (($skip_right_l < $skip_right_r) && $skip_right_ok) {
                  each {
                    var $sl_char2 { 
                      value = $input.s|substr:$skip_right_l:1 
                    }
                    var $sr_char2 { 
                      value = $input.s|substr:$skip_right_r:1 
                    }
                    conditional {
                      if ($sl_char2 != $sr_char2) {
                        var $skip_right_ok { value = false }
                      }
                    }
                    var $skip_right_l { value = $skip_right_l + 1 }
                    var $skip_right_r { value = $skip_right_r - 1 }
                  }
                }
                
                // If either skip works, it's valid
                conditional {
                  if ($skip_left_ok || $skip_right_ok) {
                    var $result { value = true }
                  }
                  else {
                    var $result { value = false }
                  }
                }
                
                var $can_delete { value = false }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
