// Restore IP Addresses - Backtracking exercise
// Given a string of digits, return all valid IP addresses
// that can be formed by inserting dots into the string
function "restore_ip_addresses" {
  description = "Find all valid IP addresses from a string of digits"
  
  input {
    text digits { description = "String containing only digits (length 4-12)" }
  }
  
  stack {
    var $results { value = [] }
    var $n { value = $input.digits|strlen }
    
    // Input validation - must be between 4 and 12 digits
    precondition ($n >= 4 && $n <= 12) {
      error_type = "inputerror"
      error = "Input must be between 4 and 12 digits"
    }
    
    // Use iterative backtracking with a stack
    // Each stack element: { pos: current position, segments: array of segments so far }
    var $stack { value = [{ pos: 0, segments: [] }] }
    
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $current { value = $stack|last }
        var $stack { value = $stack|slice:0:-1 }
        
        var $pos { value = $current.pos }
        var $segments { value = $current.segments }
        var $seg_count { value = $segments|count }
        
        // If we have 4 segments and used all digits, we found a valid IP
        conditional {
          if ($seg_count == 4 && $pos == $n) {
            var $ip { value = $segments|join:"." }
            var $results { value = $results|merge:[$ip] }
          }
        }
        
        // If we already have 4 segments but haven't used all digits, or
        // if we've used all digits but don't have 4 segments, skip
        conditional {
          if ($seg_count >= 4 || $pos >= $n) {
            // Skip this path - invalid state
          }
          else {
            // Try segments of length 1, 2, and 3
            var $max_len { value = 3 }
            
            // Don't exceed remaining digits
            conditional {
              if ($n - $pos < $max_len) {
                var $max_len { value = $n - $pos }
              }
            }
            
            // Don't create more segments than needed (max 4 total)
            var $remaining_segments { value = 4 - $seg_count }
            var $min_digits_needed { value = $remaining_segments }
            var $max_digits_available { value = $n - $pos }
            
            // Try each possible segment length
            var $len { value = 1 }
            while ($len <= $max_len) {
              each {
                // Check if taking $len digits leaves enough for remaining segments
                var $digits_after { value = $n - $pos - $len }
                var $min_needed_after { value = $remaining_segments - 1 }
                var $max_allowed_after { value = ($remaining_segments - 1) * 3 }
                
                conditional {
                  if ($digits_after >= $min_needed_after && $digits_after <= $max_allowed_after) {
                    // Extract the segment
                    var $segment { value = $input.digits|substr:$pos:($pos + $len) }
                    
                    // Validate the segment
                    var $is_valid { value = true }
                    
                    // Check for leading zeros (only "0" is valid, not "01", "00", etc.)
                    conditional {
                      if ($len > 1 && ($segment|substr:0:1) == "0") {
                        var $is_valid { value = false }
                      }
                    }
                    
                    // Check if value is 0-255
                    conditional {
                      if ($is_valid) {
                        var $seg_value { value = $segment|to_int }
                        conditional {
                          if ($seg_value < 0 || $seg_value > 255) {
                            var $is_valid { value = false }
                          }
                        }
                      }
                    }
                    
                    // If valid, push new state to stack
                    conditional {
                      if ($is_valid) {
                        var $new_segments { value = $segments|merge:[$segment] }
                        var $new_state { value = { pos: ($pos + $len), segments: $new_segments } }
                        var $stack { value = $stack|merge:[$new_state] }
                      }
                    }
                  }
                }
                
                var.update $len { value = $len + 1 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $results
}
