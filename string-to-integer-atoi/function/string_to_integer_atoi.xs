// String to Integer (atoi) - Classic coding exercise
// Implements the atoi function: converts a string to a 32-bit signed integer
// Handles whitespace, optional +/- sign, digits, and overflow
function "string_to_integer_atoi" {
  description = "Converts a string to a 32-bit signed integer (atoi implementation)"
  
  input {
    text s { description = "The string to convert to integer" }
  }
  
  stack {
    // Constants for 32-bit signed integer range
    var $INT_MAX { value = 2147483647 }
    var $INT_MIN { value = -2147483648 }
    
    // Digit lookup object for validation and conversion
    var $digit_map {
      value = {
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9
      }
    }
    
    // Check for empty string
    var $len { value = $input.s|strlen }
    
    // Default result
    var $final_result { value = 0 }
    
    conditional {
      if ($len > 0) {
        var $n { value = $len }
        var $index { value = 0 }
        
        // Skip leading whitespace
        var $has_more { value = $index < $n }
        while ($has_more) {
          each {
            var $current_char { value = $input.s|substr:$index:1 }
            var $is_space { value = ($current_char == " ") || ($current_char == "\t") || ($current_char == "\n") || ($current_char == "\r") }
            
            conditional {
              if ($is_space) {
                var.update $index { value = $index + 1 }
                var $has_more { value = $index < $n }
              }
              else {
                var $has_more { value = false }
              }
            }
          }
        }
        
        // Check if we've consumed all characters (all whitespace)
        conditional {
          if ($index < $n) {
            // Check for sign
            var $sign { value = 1 }
            var $current_char { value = $input.s|substr:$index:1 }
            
            conditional {
              if ($current_char == "-") {
                var $sign { value = -1 }
                var.update $index { value = $index + 1 }
              }
              elseif ($current_char == "+") {
                var.update $index { value = $index + 1 }
              }
            }
            
            // Parse digits
            var $result { value = 0 }
            var $has_digits { value = false }
            var $overflowed { value = false }
            
            var $can_continue { value = $index < $n }
            while ($can_continue) {
              each {
                var $current_char { value = $input.s|substr:$index:1 }
                var $is_digit { value = $digit_map|has:$current_char }
                
                conditional {
                  if ($is_digit) {
                    var $digit { value = $digit_map|get:$current_char }
                    var $has_digits { value = true }
                    
                    // Check for overflow before multiplying
                    var $max_before_mul { value = ($INT_MAX - $digit) / 10 }
                    var $would_overflow { value = $result > $max_before_mul }
                    
                    conditional {
                      if ($would_overflow) {
                        var $overflowed { value = true }
                        var $can_continue { value = false }
                      }
                      else {
                        var $result { value = ($result * 10) + $digit }
                        var.update $index { value = $index + 1 }
                        var $can_continue { value = $index < $n }
                      }
                    }
                  }
                  else {
                    var $can_continue { value = false }
                  }
                }
              }
            }
            
            // Determine final result
            conditional {
              if ($has_digits) {
                conditional {
                  if ($overflowed) {
                    conditional {
                      if ($sign == 1) {
                        var $final_result { value = $INT_MAX }
                      }
                      else {
                        var $final_result { value = $INT_MIN }
                      }
                    }
                  }
                  else {
                    var $final_result { value = $result * $sign }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  response = $final_result
}
