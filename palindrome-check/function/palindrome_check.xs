function "palindrome_check" {
  description = "Check if a given string is a palindrome (reads the same forwards and backwards)"
  input {
    text str? { description = "The string to check" }
  }
  stack {
    // Handle null or empty input
    conditional {
      if ($input.str == null || ($input.str|strlen) == 0) {
        var $is_palindrome { value = true }
      }
      else {
        // Convert to lowercase for case-insensitive check
        var $cleaned {
          value = $input.str|to_lower
        }

        // Reverse the string
        var $reversed {
          value = $cleaned|split:""|reverse|join:""
        }

        // Check if cleaned string equals its reverse
        var $is_palindrome {
          value = $cleaned == $reversed
        }
      }
    }
  }
  response = $is_palindrome
}
