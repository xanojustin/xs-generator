// Palindrome Check - Classic coding exercise
// Returns true if the input string is a palindrome (reads the same forwards and backwards)
function "palindrome_check" {
  description = "Checks if a string is a palindrome"
  
  input {
    text input_string { description = "The string to check" }
  }
  
  stack {
    // Normalize the string: lowercase and remove non-alphanumeric characters
    var $normalized {
      value = $input.input_string|to_lower|regex_replace:"[^a-z0-9]":""
    }
    
    // Reverse the normalized string
    var $reversed {
      value = $normalized|split:""|reverse|join:""
    }
    
    // Check if normalized equals reversed
    var $is_palindrome {
      value = $normalized == $reversed
    }
  }
  
  response = $is_palindrome
}
