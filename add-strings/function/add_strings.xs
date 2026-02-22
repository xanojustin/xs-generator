// Add Strings - Add two non-negative integers represented as strings
// Handles arbitrarily large numbers that exceed standard integer limits
// Uses elementary school addition algorithm (digit by digit from right to left)
function "add_strings" {
  description = "Adds two non-negative integers represented as strings"
  
  input {
    text num1 { description = "First number as a string" }
    text num2 { description = "Second number as a string" }
  }
  
  stack {
    // Get lengths of both numbers
    var $len1 { value = $input.num1|strlen }
    var $len2 { value = $input.num2|strlen }
    
    // Start from the rightmost digit
    var $i { value = $len1 - 1 }
    var $j { value = $len2 - 1 }
    var $carry { value = 0 }
    var $result { value = "" }
    
    // Process digits from right to left
    while ($i >= 0 || $j >= 0 || $carry > 0) {
      each {
        // Get current digit from num1 (or 0 if exhausted)
        var $digit1 { value = 0 }
        conditional {
          if ($i >= 0) {
            var $char1 { value = $input.num1|substr:$i:1 }
            var $digit1 { value = $char1|to_int }
          }
        }
        
        // Get current digit from num2 (or 0 if exhausted)
        var $digit2 { value = 0 }
        conditional {
          if ($j >= 0) {
            var $char2 { value = $input.num2|substr:$j:1 }
            var $digit2 { value = $char2|to_int }
          }
        }
        
        // Calculate sum of digits plus carry
        var $sum { value = $digit1 + $digit2 + $carry }
        
        // New carry is sum divided by 10
        var $new_carry { value = ($sum / 10)|floor }
        var.update $carry { value = $new_carry }
        
        // Current digit is sum modulo 10
        var $current_digit { value = $sum % 10 }
        
        // Prepend digit to result
        var $result {
          value = ($current_digit|to_text) ~ $result
        }
        
        // Move to next digits
        var.update $i { value = $i - 1 }
        var.update $j { value = $j - 1 }
      }
    }
    
    // Handle edge case where result is empty (both inputs were empty)
    conditional {
      if ($result == "") {
        var $result { value = "0" }
      }
    }
  }
  
  response = $result
}
