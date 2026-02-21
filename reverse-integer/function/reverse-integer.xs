// Reverse Integer - Classic coding exercise
// Reverses the digits of a 32-bit signed integer
// Returns 0 if the reversed integer overflows
function "reverse-integer" {
  description = "Reverses the digits of an integer, returns 0 on overflow"
  
  input {
    int x { description = "The integer to reverse" }
  }
  
  stack {
    // Constants for 32-bit signed integer bounds
    var $max_int { value = 2147483647 }
    var $min_int { value = -2147483648 }
    
    // Work with the absolute value and track sign separately
    var $num { value = $input.x }
    var $is_negative { value = false }
    
    // Handle negative numbers
    conditional {
      if ($num < 0) {
        var $is_negative { value = true }
        var $num { value = 0 - $num }
      }
    }
    
    // Reverse the digits
    var $reversed { value = 0 }
    
    while ($num > 0) {
      each {
        var $digit { value = $num % 10 }
        
        // Check for overflow before adding the digit
        // max_int / 10 = 214748364, so if reversed > 214748364, it will overflow
        // If reversed == 214748364, then digit must be <= 7 (for positive) or <= 8 (for negative)
        conditional {
          if ($reversed > 214748364) {
            return { value = 0 }
          }
          elseif ($reversed == 214748364) {
            conditional {
              if (!$is_negative && $digit > 7) {
                return { value = 0 }
              }
              elseif ($is_negative && $digit > 8) {
                return { value = 0 }
              }
            }
          }
        }
        
        var $reversed { value = ($reversed * 10) + $digit }
        var.update $num { value = $num / 10 }
      }
    }
    
    // Apply the sign
    conditional {
      if ($is_negative) {
        var $reversed { value = 0 - $reversed }
      }
    }
    
    var $result { value = $reversed }
  }
  
  response = $result
}
