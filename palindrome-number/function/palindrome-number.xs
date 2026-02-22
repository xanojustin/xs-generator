// palindrome-number.xs - Function to check if a number is a palindrome
function "palindrome-number" {
  description = "Check if an integer is a palindrome (reads the same forwards and backwards)"
  
  input {
    int num { description = "The integer to check" }
  }
  
  stack {
    // Negative numbers are not palindromes (the minus sign doesn't match)
    var $is_palindrome { value = false }
    
    conditional {
      if ($input.num < 0) {
        var $is_palindrome { value = false }
      }
      else {
        // Convert number to string to compare
        var $num_str {
          value = $input.num|to_text
        }
        
        // Get the reversed string
        var $reversed {
          value = $num_str|split:""|reverse|join:""
        }
        
        // Compare original with reversed
        conditional {
          if ($num_str == $reversed) {
            var $is_palindrome { value = true }
          }
          else {
            var $is_palindrome { value = false }
          }
        }
      }
    }
  }
  
  response = {
    is_palindrome: $is_palindrome
  }
}
